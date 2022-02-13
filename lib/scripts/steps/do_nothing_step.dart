
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';

class NothingToDoStep extends BaseStepTask {
  NothingToDoStep(StepConfigModel stepConfig) : super(stepConfig);

  @override
  Future<ExecutionResult> executeCmd(ScriptConfigModel scriptConfigs) async {
    // do nothing
    return successResult(null);
  }

  @override
  Future<bool> isLegal() {
    stepConfig.shouldLoop = false;
    return super.isLegal();
  }

  @override
  get stepName => 'do_nothing';

}