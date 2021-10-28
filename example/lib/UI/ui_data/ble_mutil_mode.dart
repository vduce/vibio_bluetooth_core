
import 'ble_mode.dart';

class BleMutilModel{
  static bool hasModel(BLEModel bleModel, List <BLEModel> list){
    if(list.length == 0){
      return false;
    }
    for(BLEModel bModel in list){
      String bModelId =  bModel.bleId.id;
       if(bModelId == bleModel.bleId.id){
         return true;
       }
    }
    return false;
  }
}