
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/script_ability.dart';
import 'package:mobile_controller/utils/log_helper.dart';

import '../../command/command_controller.dart';

/// Base step task model to provide once or looped execution ability.
/// Note that step task run finished without result.
/// @author Dorck
/// @date 2022/02/11
/// TODO: Get command configs from json config.
abstract class BaseStepTask implements Step<ScriptConfigModel> {
  final StepConfigModel stepConfig;
  int _runCount = 0;
  BaseStepTask(this.stepConfig);

  @override
  Future<ExecutionResult> stepForward(ScriptConfigModel scriptConfigs, Script<ScriptConfigModel> script) async {
    logI('Run step of $stepName' ,tag: 'BaseStepTask');
    // TODO: If not legal, should we intercept this script or continue.
    if (!await isLegal()) {
      logW('the env checks illegal !');
      return errorResult(stepConfig.toString());
    }
    if (stepConfig.shouldLoop) {
      return await loop(scriptConfigs, stepConfig.loopDuration, stepConfig.loopLimit);
    } else {
      return await executeCmd(scriptConfigs);
    }
    return script.process(scriptConfigs);
  }

  // Determine whether the current environment meets the execution conditions.
  Future<bool> isLegal() async {
    return true;
  }

  // Children need to implement the cmd executions.
  Future<ExecutionResult> executeCmd(ScriptConfigModel scriptConfigs);

  ExecutionResult errorResult(String errorMsg) => ExecutionResult.from('', false, errorMsg);

  ExecutionResult successResult(dynamic result) {
    return ExecutionResult.from(stepConfig.mark, true, result);
  }

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
    logV('loop duration is: ${duration}');
    while ((_runCount = _runCount + 1) <= limit) {
      logI('run step execution :$stepName in looper, counter times: $_runCount');
      await Future.delayed(duration, () async {
        return await executeCmd(scriptConfig);
      });
    }
  }
}

abstract class BaseRunner extends BaseStepTask {
  final RunnerConfigModel runnerConfig;
  BaseRunner(this.runnerConfig) : super(runnerConfig);

  @override
  RunnerConfigModel get stepConfig => runnerConfig;

  @override
  Future<ExecutionResult> executeCmd(ScriptConfigModel scriptConfigs) async {
    if (stepConfig is RunnerConfigModel) {
      return await CommandController.runScript(childrenSteps(), scriptConfigs);
    }
    throw const FormatException('You should give type of [RunnerConfigModel]');
  }

  // Generate inner steps implement of runner.
  List<Step<ScriptConfigModel>> childrenSteps();
}