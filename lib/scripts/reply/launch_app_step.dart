
import 'package:mobile_controller/command/command_controller.dart';
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/scripts/script_ability.dart';

/// Step execution to launch the mobile apps.
/// @author Dorck
/// @date 2022/02/10
class LaunchAppStep implements Step<String> {
  @override
  ExecutionResult run(String scriptConfigs, Script<String> script) {
    CommandController.executeAdbCommand(AdbCommand.packageInfo).then((value) {
      return value;
    });
    return ExecutionResult.from('command', false, 'can not execute');
  }

}