import 'fv_cmd.dart';
import 'main_view_type.dart';


class FVSectionData{
  //
  static final List<String > firstNames = FVData.getTopNames();
  static final List<String > firstNameCmds = FVData.topCmds();
  static final String        firstSection = "cmd-01";
  static final double        firstHeight = 60;
  static final int           firstTy = 0;
  static MainType firstType = MainType(firstNames, firstNameCmds, firstSection, firstHeight, firstTy);

  static final List<String > mainNames = FVData.getFirstMotorNames();
  static final List<String > mainNameCmds = FVData.mainMotorCmds();
  static final String        mainSection = "Main motor";
  static final double        mainHeight = 220;
  static final int           mainTy = 1;
  static MainType mainType = MainType(mainNames, mainNameCmds, mainSection, mainHeight, mainTy);

  static final List<String > subNames = FVData.getSecondMotorNames();
  static final List<String > subNameCmds = FVData.subMotorCmds();
  static final String        subSection = "Sub Motor";
  static final double        subHeight = 150;
  static final int           subTy = 2;
  static MainType subType = MainType(subNames, subNameCmds, subSection, subHeight, subTy);

  static final List<String > lastNames = FVData.getLastNames();
  static final List<String > lastNameCmds = FVData.lastCmds();
  static final String        lastSection = "cmd-02";
  static final double        lastHeight = 60;
  static final int           lastTy = 3;
  static MainType lastType = MainType(lastNames, lastNameCmds, lastSection, lastHeight, lastTy);

  static List<MainType > viewConfigs = [firstType,mainType,subType,lastType];
}