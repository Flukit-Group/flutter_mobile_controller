
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';
import '../../commands/command_controller.dart';
import '../../config/command_config.dart';

/// Mock to swipe on mobile's screen.
/// @author Dorck
/// @date 2022/02/14
class SwipeInputStep extends BaseStepTask {
  SwipeInputStep(StepConfigModel stepConfig) : super(stepConfig);

  @override
  Future<ExecutionResult> executeCmd(ExecutionResult previousResult,
      ScriptConfigModel scriptConfigs) async {
    var commandContent = CommandConfig.adbCmdInputSwipe + " "
        + (stepConfig.additionalAction ?? '');
    return await CommandController.executeAdbCommand(AdbCommand.customized,
        extArguments: commandContent);
  }

  @override
  get stepName => 'swipe_distance';

}