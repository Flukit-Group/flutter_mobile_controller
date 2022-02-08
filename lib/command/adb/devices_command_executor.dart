
import 'dart:io';

import 'package:mobile_controller/command/adb/adb_command_executor.dart';
import 'package:mobile_controller/model/execute_result.dart';
/// Implementation of command executor to fetch devices under connection.
/// @author dorck
/// @date 2022/02/08
class DevicesListCommandExecutor extends AdbCommandExecutor {
  @override
  String commandString() {
    // `adb devices`
    return 'devices';
  }

  @override
  ExecutionResult? processData(ProcessResult originData) {
    // TODO: implement processData
    throw UnimplementedError();
  }

}