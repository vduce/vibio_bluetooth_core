import 'package:flutter_blue/flutter_blue.dart';

class BLEModel{
  late String           bleName;
  late DeviceIdentifier bleId;
  late bool             connectStatus;
  late BluetoothDevice  device;
  BLEModel(this.bleName, this.bleId, this.connectStatus, this.device);
}