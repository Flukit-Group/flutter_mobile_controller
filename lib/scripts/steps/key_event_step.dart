
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';
import '../../command/command_controller.dart';
import '../../config/command_config.dart';

/// Mock key event of mobile's keyboard.
/// @author Dorck
/// @date 2022/02/14
class KeyEventStep extends BaseStepTask {
  KeyEventStep(StepConfigModel stepConfig) : super(stepConfig);

  @override
  Future<ExecutionResult> executeCmd(ExecutionResult previousResult,
      ScriptConfigModel scriptConfigs) async {
    var commandContent = CommandConfig.adbCmdInputKeyboard + " "
        + (stepConfig.additionalAction ?? '');
    return await CommandController.executeAdbCommand(AdbCommand.customized,
        extArguments: commandContent);
  }

  @override
  get stepName => 'key_event';

}