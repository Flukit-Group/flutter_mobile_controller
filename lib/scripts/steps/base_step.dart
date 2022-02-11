
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/script_ability.dart';
import 'package:mobile_controller/utils/log_helper.dart';

/// Base step task model to provide once or looped execution ability.
/// Note that step task run finished without result.
/// @author Dorck
/// @date 2022/02/11
abstract class BaseStepTask implements Step<ScriptConfigModel> {
  final StepConfigModel stepConfig;
  int _runCount = 0;
  BaseStepTask(this.stepConfig);

  @override
  Future<ExecutionResult> run(ScriptConfigModel scriptConfigs, Script<ScriptConfigModel> script) async {
    logI('Run step of $stepName' ,tag: 'BaseStepTask');
    if (stepConfig.shouldLoop) {
      await loop(scriptConfigs, stepConfig.loopDuration, stepConfig.loopLimit);
    } else {
      await executeCmd(scriptConfigs);
    }
    return script.process(scriptConfigs);
  }

  // Children need to implement the cmd executions.
  Future<void> executeCmd(ScriptConfigModel scriptConfigs);

  loop(scriptConfig, duration, limit) async {
    // var timer = Timer.periodic(duration, (timer) async {
    //   await _executeCmd();
    //   _runCount ++;
    //   logI('run step execution in looper: $_runCount');
    //   if (_runCount >= limit) {
    //     timer.cancel();
    //     logI('reach to the limit times of looper.');
    //   }
    // });
    // Return until all loop tasks run finished.
    while ((_runCount = _runCount + 1) <= limit) {
      logI('run step execution :$stepName in looper, counter times: $_runCount');
      await Future.delayed(duration, () async {
        await executeCmd(scriptConfig);
      });
    }
  }
}