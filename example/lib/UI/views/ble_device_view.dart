
import 'package:flutter/material.dart';
import 'package:vibio_bluetooth_core_example/UI/ui_data/ble_mode.dart';
import 'package:vibio_bluetooth_core_example/UI/ui_data/call_back.dart';

import 'device_item.dart';


class BLEListView extends StatefulWidget{
  final List<BLEModel> items;
  @required final bleDeviceTapFuncCallback onDeviceTap;
  BLEListView(Key key, {required this.items, required this.onDeviceTap}) : super(key: key);

  @override
  _BLEListViewState createState() => _BLEListViewState(items, onDeviceTap);
}

class _BLEListViewState extends State<BLEListView> {

  final List<BLEModel> items;
  bleDeviceTapFuncCallback ondeviceTap;
  _BLEListViewState(this.items, this.ondeviceTap);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context ,index){
           return Container(
             color: Colors.white,
             width: double.maxFinite,
             alignment: Alignment.centerLeft,
             child: MineItemWidget(items[index].bleName,items[index].connectStatus,Colors.amberAccent,items[index] ,onTap: (BLEModel bleModel){
               this.ondeviceTap(bleModel);
             }),
           );
        });
  }
}




