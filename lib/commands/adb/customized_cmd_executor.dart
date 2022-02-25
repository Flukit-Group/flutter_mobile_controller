
import 'dart:io';

import 'package:mobile_controller/commands/adb/adb_command_executor.dart';
import 'package:mobile_controller/model/execute_result.dart';

/// Customized adb executor for outer free commands.
/// @author Dorck
/// @date 2022/02/08
class CustomizedAdbCommandExecutor extends AdbCommandExecutor {
  String customizedCommand = '';

  @override
  String commandString() {
    return customizedCommand;
  }

  @override
  Future<ExecutionResult> execute({
    String executable = '',
    String extArguments = '',
    bool synchronous = false,
    bool runInShell = false,
    String? workingDirectory}) {
    customizedCommand = extArguments;
    return super.execute(executable: executable,
        extArguments: '',
        synchronous: synchronous,
        runInShell: runInShell,
        workingDirectory: workingDirectory);
  }

  @override
  ExecutionResult? processData(ProcessResult originData) {
    return null;
  }

}