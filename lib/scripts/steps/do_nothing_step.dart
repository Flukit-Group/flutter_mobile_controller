
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';

class NothingToDoStep extends BaseStepTask {
  NothingToDoStep(StepConfigModel stepConfig) : super(stepConfig);

  @override
  Future<void> executeCmd(ScriptConfigModel scriptConfigs) async {
    // do nothing
  }

  @override
  Future<bool> isLegal() {
    stepConfig.shouldLoop = false;
    return super.isLegal();
  }

  @override
  get stepName => 'do_nothing';

}