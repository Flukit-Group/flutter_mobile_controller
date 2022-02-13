
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/scripts/script_ability.dart';
import '../config/file_config.dart';
import '../model/script_config_data.dart';
import '../utils/file_utils.dart';

/// Controller to manage command executions.
/// @author Dorck
/// @date 2022/02/08
class CommandController {

  // Execute commands of adb.
  static Future<ExecutionResult> executeAdbCommand(AdbCommand command, {
    String executable = '',
    String extArguments = '',
    bool synchronous = false,
    bool runInShell = false,
    String? workingDirectory
  }) async {
    if (executable.isEmpty) {
      executable = FileConfig.adbPath;
    }
    await checkEnv(executable: executable);
    var executor = CommandConfig.adbCommandExecutors[command];
    if (executor != null) {
      var commandStr = executor.commandString();
      // if (command == AdbCommand.customized) {
      //   logI('customized command: $extArguments', tag: 'CommandController');
      // } else {
      //   logI('execute command: $commandStr, cmdType: $command', tag: 'CommandController');
      // }
      return executor.execute(executable: executable,
          extArguments: extArguments,
          synchronous: synchronous,
          runInShell: runInShell,
          workingDirectory: workingDirectory);
    } else {
      throw CommandRunException(message: 'can not find command: $command');
    }
  }

  // Run a script contains multi step commands.
  static Future<ExecutionResult> runScript(List<Step<ScriptConfigModel>> stepList, ScriptConfigModel scriptConfig) async {
    var commandScript = CommandScript(stepList, 0);
    return commandScript.process(scriptConfig);
  }

  // Group control with script on multi devices.
  static Future<ExecutionResult> groupControlWithScript(List<Step<ScriptConfigModel>> stepList, ScriptConfigModel scriptConfig) async {
    var commandScript = CommandScript(stepList, 0);
    return commandScript.process(scriptConfig);
  }

  // Check the environment of adb execution.
  static Future<void> checkEnv({String executable = ""}) async {
    if (FileConfig.adbPath == "") {
      throw CommandRunException(message: 'adb path can not be empty.');
    }
    if (!await FileUtils.isExistFile(executable)) {
      throw CommandRunException(message: 'you must set executable path to run the command');
    }
  }

}