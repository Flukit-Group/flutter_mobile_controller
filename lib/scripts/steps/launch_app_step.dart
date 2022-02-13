
import 'package:mobile_controller/command/command_controller.dart';
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';
import '../../model/script_config_data.dart';

/// Step execution to launch the mobile apps.
/// @author Dorck
/// @date 2022/02/10
class LaunchAppStep extends BaseStepTask {
  LaunchAppStep(StepConfigModel stepConfig) : super(stepConfig);

  @override
  get stepName => 'launch_app';

  @override
  Future<ExecutionResult> executeCmd(ExecutionResult previousResult, ScriptConfigModel scriptConfigs) async {
    var commandContent = CommandConfig.adbCmdLaunchAppActivity + " "
        + (stepConfig.additionalAction ?? '');
    return await CommandController.executeAdbCommand(AdbCommand.customized, extArguments: commandContent);
  }

}