
import 'package:mobile_controller/scripts/steps/input_text_step.dart';
import 'package:mobile_controller/scripts/steps/key_event_step.dart';
import 'package:mobile_controller/scripts/steps/swipe_step.dart';

import '../model/script_config_data.dart';
import '../scripts/script_ability.dart';
import '../scripts/steps/do_nothing_step.dart';
import '../scripts/steps/input_zh_text_step.dart';
import '../scripts/steps/launch_app_step.dart';
import '../scripts/steps/tap_step.dart';

class CommonDataRepository {

  List<String> defaultReplyList = [
    '真不错',
    '这么便宜，来包试试',
    ''
  ];

  // Generate step tasks from [StepConfigModel] collections.
  static List<Step<ScriptConfigModel>> generateSteps(List<StepConfigModel> stepConfigList) {
    return List.generate(stepConfigList.length, (index) {
      var configModel = stepConfigList[index];
      switch(configModel.mark) {
        case 'tap_position':
          return TapStep(configModel);
        case 'text_input':
          return InputTextStep(configModel);
        case 'text_input_zh':
          return InputChineseTextStep(configModel);
        case 'launch_app':
          return LaunchAppStep(configModel);
        case 'swipe_distance':
          return SwipeInputStep(configModel);
        case 'key_event':
          return KeyEventStep(configModel);
        default:
          return NothingToDoStep(configModel);
      }
    });
  }
}