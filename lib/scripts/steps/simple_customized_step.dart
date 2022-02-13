
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';
import 'package:mobile_controller/utils/log_helper.dart';

/// A simple customized step task to execute steps without calculations.
/// @author Dorck
/// @date 2022/02/13
class SimpleCustomizedStep extends BaseStepTask {
  SimpleCustomizedStep(StepConfigModel stepConfig, this.execute) : super(stepConfig);

  final Execute execute;

  @override
  Future<ExecutionResult> executeCmd(ExecutionResult previousResult, ScriptConfigModel scriptConfigs) async {
    return await execute.call(previousResult, stepConfig, scriptConfigs);
  }

  @override
  get stepName => stepConfig.mark;

}

typedef Execute = Future<ExecutionResult> Function(ExecutionResult previousResult, StepConfigModel stepConfig, ScriptConfigModel scriptConfig);