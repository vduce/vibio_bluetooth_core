import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:vibio_bluetooth_core/vibio_bluetooth_core.dart';
import 'package:vibio_bluetooth_core_example/UI/ui_data/ble_mode.dart';
import 'package:vibio_bluetooth_core_example/UI/ui_data/ble_mutil_mode.dart';
import 'package:vibio_bluetooth_core_example/UI/ui_data/main_view_type.dart';
import 'package:vibio_bluetooth_core_example/UI/ui_data/fv_section_data.dart';
import 'package:flutter/material.dart';
import 'package:vibio_bluetooth_core_example/UI/views/toast/dialog_utils.dart';
import 'package:vibio_bluetooth_core_example/UI/views/toast/toast_utils.dart';
import 'package:vibio_bluetooth_core_example/ble/fv_uuid.dart';
import 'package:vibio_bluetooth_core_example/flutter_helper/flutter_back_msg_callback.dart';
import 'package:vibio_bluetooth_core_example/flutter_helper/flutter_back_msg_helper.dart';
import 'package:vibio_bluetooth_core_example/flutter_helper/flutter_helper.dart';
import 'cmd_view.dart';
import 'ble_device_view.dart';



class MainView extends StatefulWidget{
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  //ble
  bool searching = false;
  bool connected = false;
  List<BluetoothService> _services = [];
  BluetoothState state = BluetoothState.unknown;
  BluetoothCharacteristic? notiyCharacteristic;
  BluetoothCharacteristic? writeCharacteristic;
  String content = "";

  //view
  final List<MainType > list = FVSectionData.viewConfigs;
  List<BLEModel> devicesList = [];
  BLEModel? connectBleModel;


  @override
  void initState() {
    // TODO: implement initState
    //state
    FlutterBlue.instance.state.listen((state) {
      String msg = "";
      if (state == BluetoothState.off) {
        msg = 'Bluetooth is off';
      }else{
        msg ='Bluetooth is on';
      }
      ToastUtils.showToast(msg);
    });
    super.initState();
  }

  //add device
  _addDeviceTolist(final BLEModel bleModel) {
    bool hasValue = BleMutilModel.hasModel(bleModel, devicesList);
    setState(() {
      if (hasValue == false) {
        devicesList.add(bleModel);
        print("in" + "$devicesList.length");
      }
    });
    print("out" + "$devicesList.length");
  }

  //clearData
  void clearData(){
    setState(() {
      devicesList.clear();
    });
  }

  //stop
  void stopScan() {
    setState(() {
      searching = false;
      widget.flutterBlue.stopScan();
    });
  }

  //scan
  void scan(String prefix) {
    ToastUtils.showToast("scaning..");
    setState(() {
      searching = true;
    });

    // Searches in already connected Devices
    // widget.flutterBlue.connectedDevices
    //     .asStream()
    //     .listen((List<BluetoothDevice> devices) {
    //   for (BluetoothDevice device in devices) {
    //     if (device.name.toString().toLowerCase().contains(prefix.toLowerCase())) {
    //       BLEModel bleModel = BLEModel(device.name, device.id, false, device);
    //       _addDeviceTolist(bleModel);
    //     }
    //   }
    // });

    // Searches for other devices
    widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        if (result.advertisementData.localName
            .toString()
            .toLowerCase()
            .contains(prefix.toLowerCase())) {
          BluetoothDevice device = result.device;
          BLEModel bleModel = BLEModel(
              device.name, device.id, false, device);
          _addDeviceTolist(bleModel);
        }
      }
    });
    widget.flutterBlue.startScan(timeout: Duration(seconds: 3));
  }

  //method
  void bleMethod(int index, int type){
    MainType mainType =  list[type];
    List<String >cmds = mainType.cmds;
    String cmd = cmds[index];

    if (type == 0) {
      if (index == 0) {
        if (searching == true) {

          //stop scan
          stopScan();


          if(connected == true){
            connectBleModel!.device.disconnect();
          }

          ToastUtils.showToast("is searching");
          return;
        }
        clearData();
        scan(FVUUID().BLENamePrefix);
      } else {
        if (connectBleModel == null) {
          ToastUtils.showToast("no device connected");
          return;
        }
        sendCommand(cmd);
      }
    } else {
      if (connectBleModel == null) {
        ToastUtils.showToast("no device connected");
        return;
      }
      sendCommand(cmd);
    }
  }

  //send Command
  void sendCommand(String command) async {
    if (!command.startsWith("MtInt:") && !command.startsWith("PowerOff")) {
      ToastUtils.showToast("sending...");
    }
    setState(() {
      content = command;
    });
    print("command: "+ command);
    final String? passText = await VibioBluetoothCore.encryptionCode(command);
    write(passText!);
  }


  //connect ble
  Future<void> connectBleDevice(BLEModel bleModel) async {
    ToastUtils.showToast("connect...");
    setState(() {
      searching = false;
    });
    try {
      //stop scan
      stopScan();

      //connect state
      connectState(bleModel);
      await bleModel.device.connect(autoConnect: false);
    } catch (e) {
      print('Error: $e');
    } finally {
    }
  }

  //connect state
  void connectState(BLEModel bleModel){
    if(bleModel.connectStatus == true){
      ToastUtils.showToast("ble is connected");
      return;
    }
    bleModel.device.state.listen((state) async {
      //disconnected
      if(state == BluetoothDeviceState.disconnected){
        print("the device is disconnect...");
        connected = false;
        bleModel.connectStatus = false;
        connectBleModel = null;
        ToastUtils.showToast("ble is disconnected");
      }
      //connected
      else if(state == BluetoothDeviceState.connected){
        //connected devices
        connected = true;
        connectBleModel = bleModel;
        bleModel.connectStatus = true;
        print("connected...");

        //notiy
        _services = await bleModel.device.discoverServices();
        _services.forEach((service) {
          if (service.uuid.toString() == FVUUID().BLEServiceUUID.toLowerCase()) {
            List<BluetoothCharacteristic> characteristics = service.characteristics;
            characteristics.forEach((characteristic) {
              print(characteristic.uuid.toString());
              //notiy characteristic
              if (characteristic.uuid.toString() == FVUUID().BLECharateristicNOTIFYUUID.toLowerCase()) {
                notiyCharacteristic = characteristic;
                notiy(notiyCharacteristic!);
              }
              //write characteristic
              if (characteristic.uuid.toString() == FVUUID().BLECharateristicWRITEUUID.toLowerCase()) {
                writeCharacteristic = characteristic;
              }
            });
          }
        });

      }
    });
  }


  //connect state
  //auth first step
  void authFirstStep(BLEModel bleModel) async{
    setState(() {
      content = "wait for first step auth";
    });
    sleep(Duration(seconds: 3));
    if (devicesList.contains(bleModel)) {
      final Map? map = await VibioBluetoothCore.firstStepParmas();
      Map data = new Map.from(map!).cast<String, String>();
      String cmd = (data["authAesMag"])!;
      write(cmd);
    }
  }



  //auth second step
  void authSecondStep(String firstStepReturnMsg) async{
    setState(() {
      content = "wait for first step auth";
    });

    final Map? map = await VibioBluetoothCore.secondStepParmas(firstStepReturnMsg);
    Map data = new Map.from(map!).cast<String, String>();
    String cmd = (data["authAesMag"])!;
    write(cmd);
  }



  //notiy
  void notiy(BluetoothCharacteristic notiyCharacteristic ) async{
    setState(() {
      content = "wait for characteristic notiy";
    });
    sleep(Duration(seconds: 3));

    List<int> bytes;
    await notiyCharacteristic.setNotifyValue(true);
    notiyCharacteristic.value.listen((value) {
      // do something with new value

      bytes = value;
      print(bytes);
      if(bytes.length == 0){
        return;
      }
      returnMsg(bytes);
    });

    //auth
    final BLEModel bleModel;
    if(connectBleModel != null) {
      bleModel =  connectBleModel!;
      authFirstStep(bleModel);
    }
  }

  void returnMsg(List<int> bytes) async{
    String backMsg = await flutterByte2hex(bytes);
    print("======backMsg===" + backMsg);
    FlutterBackMsgHelper.fvHandleMsg(backMsg, (FVBackMsgStatus type, String handleValue) {
      if (type == FVBackMsgStatus.AuthFirst) {
        authSecondStep(handleValue);
      } else {
        //
        setState(() {
          content = backMsg;
        });
      }
    });
  }

  flutterByte2hex(List<int> value) async {
    final String? hex = await VibioBluetoothCore.byte2hex(value);
    return hex;
  }

  //write
  void write(String cmdValue){
    BluetoothCharacteristic  writeChar;
    if(writeCharacteristic != null){
      writeChar = writeCharacteristic!;
      Uint8List bytes = Uint8List.fromList([]);
      bytes = FlutterHelper.toUnitList(cmdValue);
      print(bytes);
      writeChar.write(bytes);
    }
  }

  //Alert
  void showSingleAlert(String content){
    Future.delayed(Duration.zero,() {
      DialogUtils.showOneDialog(context, "Tips", content, (){
        Navigator.of(context).pop();
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: [
          //buttons
          Container(
            height: 200,
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.blue[400],
                        width: double.maxFinite,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(list[index].section,style: TextStyle(fontSize: 18.0,),textAlign: TextAlign.start,),
                      ),
                      Container(
                          child: CMDView(key: Key(index.toString()),todo: list[index], onCmdTap: (int index, int type){
                            print("index $index ; type $type");
                            bleMethod(index, type);
                          }),
                      )
                    ],
                  ),
                );
              },
            ),
          ),

          //devices
          Container(
              height: 161,
              padding: EdgeInsets.symmetric(vertical:10, horizontal:0),
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    width: double.maxFinite,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                    child: Text("BLE Devices", style: TextStyle(fontSize: 18.0,color: Colors.white), textAlign: TextAlign.start,),
                  ),
                  Container(
                    height: 100,
                    child: BLEListView(Key("listView") , items: devicesList,onDeviceTap: (BLEModel bleModel){
                       connectBleDevice(bleModel);
                    }),
                  ),
                ],
              )),

          //text
          Container(
            height: 140,
            padding: EdgeInsets.symmetric(vertical:10, horizontal:0),
            child: Column(
              children: [
                Container(
                  height: 40,
                  color: Colors.blue,
                  width: double.maxFinite,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  child: Text("Return Text", style: TextStyle(fontSize: 18.0,color: Colors.white), textAlign: TextAlign.start,),
                ),
                Container(
                  height: 80,
                  color: Colors.amberAccent,
                  width: double.maxFinite,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(content, style: TextStyle(fontSize: 18.0,), textAlign: TextAlign.center,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


