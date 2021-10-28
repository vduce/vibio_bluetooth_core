

 class FVUUID {

  //ble uuid
  final String BLENamePrefix = "vibio";
  final String BLEServiceUUID = "53300021-0050-4BD4-BBE5-A6920E4C5663";
  final String BLECharateristicWRITEUUID = "53300022-0050-4BD4-BBE5-A6920E4C5663";
  final String BLECharateristicNOTIFYUUID = "53300023-0050-4BD4-BBE5-A6920E4C5663";


  //uuid
  String bleName(){
    return BLENamePrefix;
  }

  String bleServiceUUID(){
    return BLEServiceUUID;
  }

  String bleCharateristicWRITEUUID(){
    return BLECharateristicWRITEUUID;
  }

  String bleCharateristicNOTIFYUUID(){
    return BLECharateristicNOTIFYUUID;
  }
}