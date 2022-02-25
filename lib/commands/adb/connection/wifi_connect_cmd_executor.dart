
import 'dart:io';

import 'package:mobile_controller/commands/adb/adb_command_executor.dart';
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';

/// Connect target device's ip address.
/// Note: We should transfer address value by [execute] params.
/// @author Dorck
/// @date 2022/02/13
class WifiConnectionCmdExecutor extends AdbCommandExecutor {
  @override
  String commandString() {
    // e.g. `adb connect xx:5555`
    return CommandConfig.adbCmdWirelessConnect;
  }

  @override
  ExecutionResult? processData(ProcessResult originData) {
    // Output format:
    // unable to connect to 1xx.1xx.1xx.x:5555: Connection refused
    // unable to connect to 1xx.1xx.1xx.x:5555: Operation timed out
    // connected to 1xx.1xx.1xx.x:5555
    String outputData = originData.stdout;
    if (outputData.contains('connected to')) {
      return success(outputData);

    } else {
      String errMsg = 'Unable connect with unknown error';
      if (outputData.contains('unable to connect')) {
        errMsg = outputData.split(' ').last;
      }
      return failure(errMsg);
    }
  }

}