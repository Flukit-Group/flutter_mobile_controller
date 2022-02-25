
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/script_ability.dart';
import 'package:mobile_controller/utils/log_helper.dart';

import '../../commands/command_controller.dart';

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
  Future<ExecutionResult> stepForward(ExecutionResult previousResult, ScriptConfigModel scriptConfigs, Script<ScriptConfigModel> script) async {
    logI('Run step of $stepName' ,tag: 'BaseStepTask');
    // TODO: If not legal, should we intercept this script or continue.
    if (!await isLegal()) {
      logW('the env checks illegal !');
      return errorResult(stepConfig.toString());
    }
    ExecutionResult result;
    if (stepConfig.shouldLoop) {
      result =  await loop(previousResult, scriptConfigs, stepConfig.loopDuration, stepConfig.loopLimit);
    } else {
      result = await _realExecute(stepConfig, previousResult, scriptConfigs);
      // if (stepConfig.delayTime != null) {
      //   return await _delayedExecution(previousResult, scriptConfigs, stepConfig.delayTime);
      // }
      // result = await executeCmd(previousResult, scriptConfigs);
    }
    return script.process(result, scriptConfigs);
  }

  // Determine whether the current environment meets the execution conditions.
  Future<bool> isLegal() async {
    return true;
  }

  // Children need to implement the cmd executions.
  Future<ExecutionResult> executeCmd(ExecutionResult previousResult, ScriptConfigModel scriptConfigs);

  ExecutionResult errorResult(String errorMsg) => ExecutionResult.from('', false, errorMsg);

  ExecutionResult successResult(dynamic result) {
    return ExecutionResult.from(stepConfig.mark, true, result);
  }

  _realExecute(stepConfig, previousResult, scriptConfig) async {
    if (stepConfig.delayTime != null) {
      return await _delayedExecution(previousResult, scriptConfig, stepConfig.delayTime);
    }
    return await executeCmd(previousResult, scriptConfig);
  }

  Future<ExecutionResult> _delayedExecution(previousResult, scriptConfig, delayTime) async {
    return await Future.delayed(delayTime, () async {
      return await executeCmd(previousResult, scriptConfig);
    });
  }

  loop(ExecutionResult previousResult, scriptConfig, duration, limit) async {
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
        return await _realExecute(stepConfig, previousResult, scriptConfig);
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
  Future<ExecutionResult> executeCmd(ExecutionResult previousResult, ScriptConfigModel scriptConfigs) async {
    if (stepConfig is RunnerConfigModel) {
      return await CommandController.runScript(childrenSteps(), scriptConfigs);
    }
    throw const FormatException('You should give type of [RunnerConfigModel]');
  }

  // Generate inner steps implement of runner.
  List<Step<ScriptConfigModel>> childrenSteps();
}