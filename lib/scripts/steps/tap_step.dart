
import 'dart:async';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';
import '../../command/command_controller.dart';
import '../../config/command_config.dart';

class TapStep extends BaseStepTask {

  TapStep(StepConfigModel stepConfig) : super(stepConfig);

  _executeCmd() async {
    var commandContent = CommandConfig.adbCmdInputTap + " "
        + (stepConfig.additionalAction ?? '');
    await CommandController.executeAdbCommand(AdbCommand.customized, extArguments: commandContent);
  }

  @override
  get stepName => 'tap_position';

  @override
  Future<void> executeCmd(ScriptConfigModel scriptConfigs) async {
    await _executeCmd();
  }

}