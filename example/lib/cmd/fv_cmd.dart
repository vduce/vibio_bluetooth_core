

import 'package:intl/intl.dart';


class FVCmd {
  //ble cmd
  final String BatteryCmd = "Battery;";  //Battery
  final String PowerOffCmd = "PowerOff;";//Power Off
  final String LightOffCmd = "Light:0;"; //off
  final String LightOnCmd = "Light:1;";  //on
  final String GetLight = "GetLight;";   //Light state
  final String DeviceType = "GetVer;";
  final String MtInt = "MtInt:";
  final String Motor = "Mod";
  final String GetMotor = "GetMotor;";
  final String StopMotor = "Stop";

  String battery(){
    return BatteryCmd;
  }

  String powerOff(){
    return PowerOffCmd;
  }

  String getLight(){
    return GetLight;
  }

  String Light(bool isOn){
    if (isOn){
      return LightOnCmd;
    }
    return LightOffCmd;
  }

  String deviceType(){
     return DeviceType;
  }


  String GetMotorCount(){
    return GetMotor;
  }

  String stopMotor(int motorId){
    return StopMotor + motorId.toString() + ";";
  }


  /// motor
  /// @param motorID Motor ID value: 0 ~ 1
  /// @param patternId pattern id value:(01：Accelerator;  02：Cha cha cha;  03：Constant;  04：Pulse;  05：Wave)
  /// @param motorIntensity motor Intensity value: 00~99
  /// @param motorSpeed motor Speed
  /// @param cycletime cycle time
  String motorCmd(int motorID, int patternId, int motorIntensity, int motorSpeed, int cycleTime){
    NumberFormat formatter = NumberFormat("00");
    return Motor + motorID.toString() + ":" +
        formatter.format(patternId) +
        formatter.format(motorIntensity) +
        formatter.format(motorSpeed) +
        formatter.format(cycleTime) + ";";
  }


  /// Set Motor Intensity
  /// @param mainMotorIntensity Main Motor Intensity, Val: 00~99
  /// @param subMotorIntensity Sub Motor Intensity, Val: 00~99
  ///
  String mtIntMotor(int mainMotorIntensity, int subMotorIntensity){
    NumberFormat formatter = NumberFormat("00");
    return MtInt + formatter.format(mainMotorIntensity)  + formatter.format(mainMotorIntensity) + ";";
  }


}
