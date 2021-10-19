
import 'package:vibio_bluetooth_core_example/cmd/fv_cmd.dart';
import 'main_view_type.dart';


class FVData{

  ///names
  static final List<String > topNames = ["Scan","Battery","Device"];
  static List<String > getTopNames(){
    return topNames;
  }

  static final List<String > firstMotorNames = ["MainMotor55","MainMotor99","CONS","ACC99","ACC50","PUL99","CHA99", "CHA50","PUL50","WAVE99","WAVE50","STOP"];
  static List<String > getFirstMotorNames(){
    return firstMotorNames;
  }

  static final List<String > secondMotorNames = ["SubMotor55","SubMotor99","CONS","ACC99","PUL99","CHA99","WAVE99","STOP"];
  static List<String > getSecondMotorNames(){
    return secondMotorNames;
  }

  static final List<String > lastNames = ["LED ON","LED OFF","Power OFF","Get Motor"];
  static List<String > getLastNames(){
    return lastNames;
  }

  ///cmds
  static List<String > topCmds(){
    String scan = "";
    String battery = FVCmd().battery();
    String device = FVCmd().deviceType();
    return [scan,battery,device];
  }

  static List<String > mainMotorCmds(){
    String main_motor_intensity_50_cmd = FVCmd().mtIntMotor(50, 0);
    String main_motor_intensity_99_cmd = FVCmd().mtIntMotor(99, 0);
    String cons_cms = FVCmd().motorCmd(0, 3, 99, 0, 0);
    String acc_99_cmd = FVCmd().motorCmd(0, 1, 99, 9, 0);
    String acc_50_cmd = FVCmd().motorCmd(0, 1, 50, 2, 0);
    String pul_99_cmd = FVCmd().motorCmd(0, 4, 99, 2, 0);
    String cha_99_cmd = FVCmd().motorCmd(0, 2, 99, 4, 0);
    String cha_50_cmd = FVCmd().motorCmd(0, 2, 50, 8, 0);
    String pul_50_cmd = FVCmd().motorCmd(0, 4, 50, 8, 0);
    String wave_99_cmd = FVCmd().motorCmd(0, 5, 99, 5, 4);
    String wave_50_cmd = FVCmd().motorCmd(0, 5, 50, 5, 10);
    String stop_cmd = FVCmd().stopMotor(0);
    return [main_motor_intensity_50_cmd,main_motor_intensity_99_cmd, cons_cms,
      acc_99_cmd,acc_50_cmd,pul_99_cmd,cha_99_cmd,cha_50_cmd,pul_50_cmd,wave_99_cmd,wave_50_cmd,stop_cmd];
 }

  static List<String > subMotorCmds(){
    String sub_motor_intensity_50_cmd = FVCmd().mtIntMotor(0, 50);
    String sub_motor_intensity_99_cmd = FVCmd().mtIntMotor(0, 99);

    String cons_cms = FVCmd().motorCmd(1, 3, 99, 0, 0);
    String acc_99_cmd = FVCmd().motorCmd(1, 1, 99, 9, 0);
    String pul_99_cmd = FVCmd().motorCmd(1, 4, 99, 2, 0);
    String cha_99_cmd = FVCmd().motorCmd(1, 2, 99, 4, 0);
    String wave_99_cmd = FVCmd().motorCmd(1, 5, 99, 5, 4);
    String stop_cmd = FVCmd().stopMotor(1);
    return [sub_motor_intensity_50_cmd,sub_motor_intensity_99_cmd, cons_cms,
      acc_99_cmd,pul_99_cmd,cha_99_cmd,wave_99_cmd,stop_cmd];
  }

  static List<String > lastCmds(){
    String LEDON = FVCmd().Light(true);
    String LEDOFF = FVCmd().Light(false);
    String PowerOFF = FVCmd().powerOff();
    String GetMotor = FVCmd().GetMotorCount();

    return [LEDON,LEDOFF,PowerOFF,GetMotor];
  }
}