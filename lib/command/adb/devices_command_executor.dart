
import 'dart:io';

import 'package:mobile_controller/command/adb/adb_command_executor.dart';
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';

import '../../utils/platform_adapt_utils.dart';
/// Implementation of command executor to fetch devices under connection.
/// @author dorck
/// @date 2022/02/08
class DevicesListCommandExecutor extends AdbCommandExecutor {
  @override
  String commandString() {
    // `adb devices`
    return CommandConfig.adbCmdDevList;
  }

  @override
  ExecutionResult? processData(ProcessResult originData) {
    String outData = originData.stdout;
    if (outData.contains("List of devices attached")) {
      List<String> devices = outData.split(PlatformAdaptUtils.getLineBreak());
      List<String> currentDevices = [];
      for (var element in devices) {
        if (element.isNotEmpty && element != "List of devices attached") {
          if (!element.contains("offline")) {
            currentDevices.add(element.split("\t")[0]);
          } else {
            currentDevices.add(element);
          }
        }
      }
      if (currentDevices.isNotEmpty) {
        return ExecutionResult.from(fullCommand, true, currentDevices);
      } else {
        return ExecutionResult.from(fullCommand, false, "No device connected!");
      }
    } else {
      return ExecutionResult.from(fullCommand, false, outData);
    }
  }

}