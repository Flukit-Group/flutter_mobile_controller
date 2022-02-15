
import 'package:mobile_controller/command/command_controller.dart';
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'base_step.dart';

class InputTextStep extends BaseStepTask {

  InputTextStep(StepConfigModel stepConfig) : super(stepConfig);

  @override
  Future<ExecutionResult> executeCmd(ExecutionResult previousResult, ScriptConfigModel scriptConfigs) async {
    var commandContent = CommandConfig.adbCmdInputText + " ";
    return await CommandController.executeAdbCommand(AdbCommand.customized,
        extArguments: commandContent + stepConfig.additionalAction!);
  }

  @override
  get stepName => 'text_input';

}