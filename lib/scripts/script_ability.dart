
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/utils/log_helper.dart';

/// Provides scripting capabilities composed of multiple command
/// sequential executions based on Chain of Responsibility pattern.
/// @author Dorck
/// @date 2022/02/10
/// TODO: Handle if middle step execute failed.
class CommandScript implements Script<ScriptConfigModel> {

  CommandScript(this.steps, this.stepIndex);

  final List<Step<ScriptConfigModel>> steps;
  final int stepIndex;

  @override
  ExecutionResult process(ScriptConfigModel configs) {
    if (stepIndex <= 0 || stepIndex > steps.length) {
      throw CommandRunException(message: 'stepIndex is out of steps.length');
    }
    int curIndex = stepIndex;
    Step<ScriptConfigModel>? curStep;
    while(curIndex >= 0 && curIndex < steps.length) {
      curIndex ++;
    }
    curStep = steps[curIndex];
    if (curStep != null) {
      return curStep.run(configs, CommandScript(steps, curIndex + 1));
    }
    var error = 'can not find available steps to execute.';
    logE(error, tag: 'CommandScript');
    return ExecutionResult.from('', false, error);
  }

}

abstract class Step<T> {
  ExecutionResult run(T scriptConfigs, Script<T> script);

  get stepName;
}

abstract class Script<R> {
  ExecutionResult process(R scriptConfigs);
}