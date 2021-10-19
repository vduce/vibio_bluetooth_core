import 'package:flutter/material.dart';
import 'package:vibio_bluetooth_core_example/UI/ui_data/ble_mode.dart';
import 'package:vibio_bluetooth_core_example/UI/ui_data/call_back.dart';

class MineItemWidget extends StatefulWidget{
  final String bleName;
  final bool connectStatus;
  final BLEModel bleModel;
  final Color  bgColor;
  @required final bleDeviceTapFuncCallback onTap;
  MineItemWidget(this.bleName,this.connectStatus,this.bgColor, this.bleModel, {required this.onTap});

  @override
  _MineItemWidgetState createState() => _MineItemWidgetState(bgColor,bleName,connectStatus,bleModel,onTap);
}

class _MineItemWidgetState extends State<MineItemWidget> {
  Color bgColor;
  String bleName;
  bool connectStatus;
  BLEModel bleModel;
  bleDeviceTapFuncCallback ontap;
  _MineItemWidgetState(this.bgColor,this.bleName,this.connectStatus,this.bleModel,this.ontap);


  @override
  Widget build(BuildContext context) {
    return Container(
        color: bgColor,
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              child: InkWell(
                onTap: () {
                  this.ontap(bleModel);
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "$bleName",
                          style: TextStyle(fontSize: 16),
                        ),

                      ),
                    ),
                    // Expanded(
                    //   flex: 1,
                    //   child: Container(
                    //     padding: EdgeInsets.only(left: 10),
                    //     child: Text(
                    //       bleSSI,
                    //       style: TextStyle(fontSize: 12),
                    //     ),
                    //
                    //   ),
                    // ),
                    // Expanded(
                    //   flex: 2,
                    //   child: Container(
                    //     padding: EdgeInsets.only(right: 10),
                    //     child: Text(
                    //       connectStatus == true ? "connected": "not connect",
                    //       style: TextStyle(fontSize: 12),
                    //     ),
                    //   ),
                    // ),
                    _listViewLine,
                  ],
                ),
              ),
            ),
            Container(
              color: Color(0xffeaeaea),
              constraints: BoxConstraints.expand(height: 1.0),
            ),
          ],
        )
    );
  }

}

Widget get _listViewLine {
  return Container(
    color: Color(0xffeaeaea),
    height: 1,
  );
}