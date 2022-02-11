
import 'package:mobile_controller/command/command_controller.dart';
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/scripts/script_ability.dart';

import '../../model/script_config_data.dart';

/// Step execution to launch the mobile apps.
/// @author Dorck
/// @date 2022/02/10
class LaunchAppStep implements Step<ScriptConfigModel> {
  final StepConfigModel stepConfigModel;
  LaunchAppStep(this.stepConfigModel);

  @override
  ExecutionResult run(ScriptConfigModel scriptConfigs, Script<ScriptConfigModel> script) {
    //var stepConfig = scriptConfigs.stepConfigs[stepName];
    var commandContent = CommandConfig.adbCmdLaunchAppActivity + " "
        + (stepConfigModel.additionalAction ?? '');
    CommandController.executeAdbCommand(AdbCommand.customized, extArguments: commandContent).then((value) {
      return value;
    });
    return script.process(scriptConfigs);
    //return ExecutionResult.from('command', false, 'can not execute');
  }

  @override
  get stepName => 'launch_app';

}