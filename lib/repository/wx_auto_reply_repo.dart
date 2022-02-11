
import 'package:mobile_controller/command/command_controller.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/script_ability.dart';
import 'package:mobile_controller/scripts/steps/launch_app_step.dart';
import 'package:mobile_controller/scripts/steps/tap_step.dart';

class WxAutoReplyRepository {
  ScriptConfigModel scriptConfigModel = ScriptConfigModel('wechat-auto-reply', {
    'launch_app': StepConfigModel(
      'launch_app',
      additionalAction: 'com.tencent.mm/.ui.LauncherUI',
    ),
    'tap_position': StepConfigModel(
      'launch_app',
      additionalAction: 'com.tencent.mm/.ui.LauncherUI',
    ),
  });

  List<Step<ScriptConfigModel>> stepList = [
    LaunchAppStep(StepConfigModel('launch_app',
      additionalAction: 'com.tencent.mm/.ui.LauncherUI',)),
    TapStep(StepConfigModel('tap_position',
      additionalAction: '947 2318',)),

  ];


  Future<ExecutionResult> runScript() async {
    return await CommandController.runScript(stepList, scriptConfigModel);
  }
}