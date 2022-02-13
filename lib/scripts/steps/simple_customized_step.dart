
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';

/// A simple customized step task to execute steps without calculations.
/// @author Dorck
/// @date 2022/02/13
class SimpleCustomizedStep extends BaseStepTask {
  SimpleCustomizedStep(StepConfigModel stepConfig, this.execute) : super(stepConfig);

  final Function(StepConfigModel, ScriptConfigModel)? execute;

  @override
  Future<ExecutionResult> executeCmd(ScriptConfigModel scriptConfigs) async {
    return execute?.call(stepConfig, scriptConfigs);
  }

  @override
  get stepName => stepConfig.mark;

}