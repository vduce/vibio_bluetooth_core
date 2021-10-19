

//type:
/*{
   1:auth firstStep ==>;
   2.GetVer;        ==>S:Y003:0001;
   3.GetLight;      ==>Light:1;
   4.GetMotor;      ==>Motor:1;
   5.Battery;       ==>90;
   6.(auth secondStep) or (Light:1;) or (Light:0;)
   or (Set Motor Pre-Pattern) or (Stop Motor Vibrate) ==> OK;

   7.(PowerOff;) or (Set Motor Intensity) ==> no return
 }
 */
enum FVBackMsgStatus {
  AuthFirst,
  GetVersion,
  GetLight,
  GetMotor,
  GetBattery,
  Other,
  None,
}

typedef flutterBackMsgCallBack = void Function(FVBackMsgStatus type, String handleValue);


