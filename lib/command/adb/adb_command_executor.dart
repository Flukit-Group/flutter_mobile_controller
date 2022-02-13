
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/utils/log_helper.dart';
import '../../config/command_config.dart';
import '../../config/common_config.dart';
import '../../utils/platform_adapt_utils.dart';

/// Abstract executor for adb command.
/// @author dorck
/// @date 2022/02/08
abstract class AdbCommandExecutor {
  // Whole command content. e.g.,`adb devices`
  String fullCommand = '';

  /// Implementation of normal command execution.
  /// If this is [AdbCommand.customized], we use [extArguments] as command content.
  Future<ExecutionResult> execute({
    String executable = '',
    String extArguments = '',
    bool synchronous = false,
    bool runInShell = false,
    String? workingDirectory
  }) async {
    String finalCommand = commandString();
    if (extArguments.isNotEmpty) {
      finalCommand = finalCommand + ' $extArguments';
    }
    fullCommand = finalCommand;
    List<String> args = finalCommand.split(" ");
    // In most cases, we need to specify the device to execute the command.
    if (CommonConfig.currentAndroidDevice.isNotEmpty) {
      var mainCmd = args[0];
      if (mainCmd != CommandConfig.adbCmdDevList &&
          mainCmd != CommandConfig.adbCmdWirelessConnect &&
          mainCmd != CommandConfig.adbCmdWirelessDisconnect &&
          mainCmd != CommandConfig.adbCmdVersion) {
        args = ["-s", CommonConfig.currentAndroidDevice, ...args];
      }
    }
    var processResult = await _runCmd(args, executable: executable,
        synchronous: synchronous, runInShell: runInShell, workingDirectory: workingDirectory);
    logI('executable: $executable, arguments: $args, output: ${processResult.stdout}', tag: 'AdbCommandExecutor');
    // TODO: Check for multi devices operation at same time.
    if (processResult.stderr != "") {
      if (processResult.stderr
          .toString()
          .contains("more than one device/emulator")) {
        return ExecutionResult.from(finalCommand, false,
            "More than one device now, only can operate one at same time!", originData: processResult);
      }
      return ExecutionResult.from(finalCommand, false, processResult.stderr, originData: processResult);
    }
    // Data wrapper intercept.
    var interceptorDataWrapper = processData(processResult);
    if (interceptorDataWrapper != null) {
      return interceptorDataWrapper;
    }
    return ExecutionResult.from(finalCommand, true, processResult.stdout, originData: processResult);
  }

  Future<ProcessResult> _runCmd(List<String> args, {
    String executable = '',
    bool synchronous = false,
    bool runInShell = false,
    String? workingDirectory
  }) async {
    if (args.contains("grep") && !args.contains("dropbox")) {
      int index = args.indexOf("grep");
      args[index] = PlatformAdaptUtils.grepFindStr();
    }
    if (synchronous) {
      return Process.runSync(executable, args,
          workingDirectory: workingDirectory,
          runInShell: runInShell,
          stdoutEncoding: Encoding.getByName("utf-8"));
    } else {
      return await Process.run(executable, args,
          workingDirectory: workingDirectory,
          runInShell: runInShell,
          stdoutEncoding: Encoding.getByName("utf-8"));
    }
  }

  /// Handle original execution result as we wanted.
  /// If method returns null, [execute] will return original data without wrapper.
  ExecutionResult? processData(ProcessResult originData);

  ExecutionResult success(dynamic result) {
    return ExecutionResult.from(fullCommand, true, result);
  }

  ExecutionResult failure(String errorMsg) {
    return ExecutionResult.from(fullCommand, false, errorMsg);
  }

  @mustCallSuper
  String commandString();
}