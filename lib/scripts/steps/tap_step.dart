
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/script_ability.dart';
import '../../command/command_controller.dart';
import '../../config/command_config.dart';

class TapStep implements Step<ScriptConfigModel> {
  final StepConfigModel stepConfig;
  TapStep(this.stepConfig);

  @override
  ExecutionResult run(ScriptConfigModel scriptConfigs, Script<ScriptConfigModel> script) {
    //var stepConfig = scriptConfigs.stepConfigs[stepName];
    var commandContent = CommandConfig.adbCmdInputTap + " "
        + (stepConfig.additionalAction ?? '');
    CommandController.executeAdbCommand(AdbCommand.customized, extArguments: commandContent).then((value) {
      return value;
    });
    return script.process(scriptConfigs);
    //return ExecutionResult.from('command', false, 'can not execute');
  }

  @override
  get stepName => 'tap_position';

}