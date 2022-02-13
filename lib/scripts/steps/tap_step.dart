
import 'dart:async';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';
import '../../command/command_controller.dart';
import '../../config/command_config.dart';

/// Mock to click on mobile's screen.
/// @author Dorck
/// @date 2022/02/08
class TapStep extends BaseStepTask {

  TapStep(StepConfigModel stepConfig) : super(stepConfig);

  _executeCmd() async {
    var commandContent = CommandConfig.adbCmdInputTap + " "
        + (stepConfig.additionalAction ?? '');
    return await CommandController.executeAdbCommand(AdbCommand.customized, extArguments: commandContent);
  }

  @override
  get stepName => 'tap_position';

  @override
  Future<ExecutionResult> executeCmd(ExecutionResult previousResult, ScriptConfigModel scriptConfigs) async {
    return await _executeCmd();
  }

}