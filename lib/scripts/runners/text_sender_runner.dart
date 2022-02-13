
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/repository/wx_auto_reply_repo.dart';
import 'package:mobile_controller/scripts/script_ability.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';

/// A special [Step] that can combine any number of steps into a runner for execution.
/// Runner to auto fill text in input box and send in loop execution.
/// @author Dorck
/// @date 2022/02/12
class TextSenderRunner extends BaseRunner {
  TextSenderRunner(RunnerConfigModel runnerConfig) : super(runnerConfig);

  @override
  get stepName => 'text_input_sender_runner';

  @override
  List<Step<ScriptConfigModel>> childrenSteps() {
    return WxAutoReplyRepository().generateSteps(stepConfig.children!);
  }

}