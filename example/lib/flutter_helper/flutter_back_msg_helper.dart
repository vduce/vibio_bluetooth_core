

import 'flutter_back_msg_callback.dart';

//type:
/*{
   1:auth firstStep ==>;usus:isisusss;
   2.GetVer;        ==>S:Y003:0001;
   3.GetLight;      ==>Light:1;
   4.GetMotor;      ==>Motor:1;
   5.Battery;       ==>90;
   6.(auth secondStep) or (Light:1;) or (Light:0;) or (Set Motor Pre-Pattern) or (Stop Motor Vibrate) ==> OK;
   //
   7.(PowerOff;) or (Set Motor Intensity) ==> no return
 }
 */

class FlutterBackMsgHelper{

   static void fvHandleMsg(String returnMsg, flutterBackMsgCallBack callBack){

     String lastCode =  returnMsg.replaceRange (returnMsg.length-1,returnMsg.length,"");
     //GetVer;
     String versionPrefix = "S:";
     //GetLight;
     String lightPrefix = "Light:";
     //GetMotor;
     String motorPrefix = "Motor:";
     //
     String hasColon = ":";
     //OK;
     String hasOK = "OK;";

     FVBackMsgStatus status = FVBackMsgStatus.None;
     if(lastCode.startsWith(versionPrefix)){
       status = FVBackMsgStatus.GetVersion;
       callBack(status,lastCode);
     }
     else if(lastCode.startsWith(lightPrefix)){
       status = FVBackMsgStatus.GetLight;
       List<String> temp = lastCode.split(":");
       if(2 == temp.length){
         callBack(status,temp[1]);
       }
     }
     else if(lastCode.startsWith(motorPrefix)){
       status = FVBackMsgStatus.GetMotor;
       callBack(status,lastCode);
     }else if(returnMsg.contains(hasColon)){
       //auth firstStep
       List<String> temp = lastCode.split(hasColon);
       if (2 == temp.length){
         status = FVBackMsgStatus.AuthFirst;
         callBack(status,temp[1]);
       }
     }else if(returnMsg == hasOK){
       //OK;
       status = FVBackMsgStatus.Other;
       callBack(status,lastCode);
     }else{
       //90;
       status = FVBackMsgStatus.GetBattery;
       callBack(status,lastCode);
     }
  }
}