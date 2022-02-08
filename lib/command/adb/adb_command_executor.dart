
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_controller/command/android_command.dart';
import 'package:mobile_controller/model/execute_result.dart';
/// Abstract executor for adb command.
/// @author dorck
/// @date 2022/02/08
abstract class AdbCommandExecutor {
  // Whole command content. e.g.,`adb devices`
  String fullCommand = '';

  /// Implementation of command execution.
  Future<ExecutionResult> execute({String executable = '', String extArguments = ''}) async {
    var commandController = AndroidCommand();
    String finalCommand = commandString();
    if (extArguments.isNotEmpty) {
      finalCommand = finalCommand + ' $extArguments';
    }
    fullCommand = finalCommand;
    List<String> args = extArguments.split(" ");
    var processResult = await commandController.execCommand(args, executable: executable);
    var interceptorDataWrapper = processData(processResult);
    if (interceptorDataWrapper != null) {
      return interceptorDataWrapper;
    }
    return commandController.dealWithData(commandString(), processResult);
    
  }

  /// Handle original execution result as we wanted.
  /// If method returns null, [execute] will return original data without wrapper.
  ExecutionResult? processData(ProcessResult originData);

  @mustCallSuper
  String commandString();
}