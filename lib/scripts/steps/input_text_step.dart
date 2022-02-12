
import 'dart:math';

import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/repository/common_repository.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';
import '../../command/command_controller.dart';
import '../../config/command_config.dart';

class InputTextStep extends BaseStepTask {
  static const String adbKeyBoardPackage = 'com.android.adbkeyboard';

  InputTextStep(StepConfigModel stepConfig) : super(stepConfig);

  @override
  Future<void> executeCmd(ScriptConfigModel scriptConfigs) async {
    var commandContent = CommandConfig.adbCmdInputTextByBroadcast + " ";
    // todo: provide interceptor ability from [ScriptConfigModel]
    var msg = '';
    if (stepConfig.additionalAction != null && stepConfig.additionalAction == 'random') {
      // Read random content from configs.
      var dataSource = CommonDataRepository().defaultReplyList;
      msg = dataSource[Random().nextInt(dataSource.length)];
    }
    var finalCmd = commandContent + msg;
    await CommandController.executeAdbCommand(AdbCommand.customized, extArguments: finalCmd);
  }

  @override
  Future<bool> isLegal() async {
    // Do judgement if AdbKeyBoard app is installed.
    var result = (await CommandController.executeAdbCommand(AdbCommand.customized,
        extArguments: CommandConfig.adbCmdPackageIsInstalled + ' ' + adbKeyBoardPackage
    )).toString();
    return result.contains(adbKeyBoardPackage);
  }

  @override
  get stepName => 'text_input';

}