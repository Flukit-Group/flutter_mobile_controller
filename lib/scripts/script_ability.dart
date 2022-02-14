
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/utils/log_helper.dart';

/// Provides scripting capabilities composed of multiple command
/// sequential executions based on Chain of Responsibility pattern.
/// @author Dorck
/// @date 2022/02/10
/// TODO: Handle if middle step execute failed.
/// TODO: Use config models of step as param instead of [Step].
class CommandScript implements Script<ScriptConfigModel> {

  CommandScript(this.steps, this.stepIndex);

  final List<Step<ScriptConfigModel>> steps;
  final int stepIndex;

  @override
  Future<ExecutionResult> process(ExecutionResult? previousResult, ScriptConfigModel configs) async {
    logV('step index: $stepIndex');
    if (stepIndex < 0 || stepIndex > steps.length) {
      throw CommandRunException(message: 'stepIndex $stepIndex is out of steps.length');
    }
    int curIndex = stepIndex;
    Step<ScriptConfigModel>? curStep;
    while(curIndex >= 0 && curIndex < steps.length && (curStep = steps[curIndex]) == null) {
      curIndex ++;
    }
    if (curStep != null) {
      return await curStep.stepForward(previousResult!, configs, CommandScript(steps, curIndex + 1));
    }
    var msg = 'can not find available steps to execute.';
    logD(msg, tag: 'CommandScript');
    return previousResult ?? ExecutionResult.from(configs.toString(), true, msg);
  }

}

abstract class Step<T> {
  Future<ExecutionResult> stepForward(ExecutionResult previousResult, T scriptConfigs, Script<T> script);

  get stepName;
}

abstract class Script<R> {
  Future<ExecutionResult> process(ExecutionResult previousResult, R scriptConfigs);
}