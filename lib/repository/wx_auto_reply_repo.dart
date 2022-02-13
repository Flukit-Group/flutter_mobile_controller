
import 'package:mobile_controller/command/command_controller.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/runners/text_sender_runner.dart';
import 'package:mobile_controller/scripts/script_ability.dart';
import 'package:mobile_controller/scripts/steps/do_nothing_step.dart';
import 'package:mobile_controller/scripts/steps/input_text_step.dart';
import 'package:mobile_controller/scripts/steps/launch_app_step.dart';
import 'package:mobile_controller/scripts/steps/tap_step.dart';

// Execution entrance of wechat scripts.
// @author Dorck
class WxAutoReplyRepository {
  ScriptConfigModel scriptConfigModel = ScriptConfigModel('wechat-auto-reply', additionalActions: {
    'launch_app': '',
    'tap_position': '',
  });

  List<Step<ScriptConfigModel>> openLiveTabStepList = [
    LaunchAppStep(
        StepConfigModel('launch_app',
          additionalAction: 'com.tencent.mm/.ui.LauncherUI',
        )
    ),
    // click bottom discover tab
    TapStep(
        StepConfigModel(
          'tap_position',
          additionalAction: '684 2318',
        )
    ),
    // click wechat live show entrance
    TapStep(
        StepConfigModel(
          'tap_position',
          additionalAction: '556 624',
        )
    ),
    // tap first live show pos and enter in
    TapStep(
        StepConfigModel(
          'tap_position',
          additionalAction: '293 755',
        )
    ),

  ];


  Future<ExecutionResult> openLiveEntrance() async {
    return await CommandController.runScript(openLiveTabStepList, scriptConfigModel);
  }

  Future<ExecutionResult> autoReplyAtFirstLiveShow() async {
    List<Step<ScriptConfigModel>> autoReplyStepList = [];
    var loopRunnerSteps = [
      // click comment button
      StepConfigModel(
        'tap_position',
        additionalAction: '171 2270',
      ),
      // set input text
      StepConfigModel(
          'text_input',
          additionalAction: 'random',
      ),
      // click send button
      StepConfigModel(
        'tap_position',
        additionalAction: '744 2021',
      ),
    ];
    var runnerConfig = RunnerConfigModel('text_input_sender_runner', loopRunnerSteps);
    runnerConfig.shouldLoop = true;
    runnerConfig.loopLimit = 5;
    runnerConfig.loopDuration = Duration(milliseconds: 5000);
    var loopCommentRunner = TextSenderRunner(runnerConfig);
    autoReplyStepList.addAll(openLiveTabStepList);
    autoReplyStepList.add(loopCommentRunner);
    return await CommandController.runScript(autoReplyStepList, scriptConfigModel);
  }

  // Generate step tasks from [StepConfigModel] collections.
  List<Step<ScriptConfigModel>> generateSteps(List<StepConfigModel> stepConfigList) {
    return List.generate(stepConfigList.length, (index) {
      var configModel = stepConfigList[index];
      if (configModel.mark == 'tap_position') {
        return TapStep(configModel);
      } else if (configModel.mark == 'text_input') {
        return InputTextStep(configModel);
      } else if (configModel.mark == 'launch_app') {
        return LaunchAppStep(configModel);
      }
      return NothingToDoStep(configModel);
    });
  }
}