
import 'ble_mode.dart';

typedef bleDeviceTapFuncCallback = void Function(BLEModel bleModel);

//type  1:top 2:mainmotor 3:sub motor 4:last
typedef cmdTapFuncCallback = void Function(int index, int type);
