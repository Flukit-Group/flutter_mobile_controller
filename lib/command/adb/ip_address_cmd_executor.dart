
import 'dart:io';

import 'package:mobile_controller/command/adb/adb_command_executor.dart';
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/utils/log_helper.dart';
import 'package:mobile_controller/utils/platform_adapt_utils.dart';

/// Query the ip address of Android device.
/// @author Dorck
/// @date 2022/02/13
class IpAddressCommandExecutor extends AdbCommandExecutor {
  @override
  String commandString() {
    return CommandConfig.adbCmdWlanIpAddress;
  }

  @override
  ExecutionResult? processData(ProcessResult originData) {
    String output = originData.stdout;
    logI('output of ip address: $output');
    String addr = _extractAddress(output);
    if (!output.contains('inet addr:') || addr.isEmpty) {
      return ExecutionResult.from(fullCommand, false, "Can not get ip addr of wlan", originData: originData);
    }
    return ExecutionResult.from(fullCommand, true, addr, originData: originData);
  }

  String _extractAddress(target) {
    if (!target.contains('inet addr:')) {
      return '';
    }
    String hitLine = '';
    var lines = target.split(PlatformAdaptUtils.getLineBreak());
    for (String curLine in lines) {
      if (curLine.contains('inet addr:')) {
        hitLine = curLine;
        break;
      }
    }
    var splitArray = hitLine.split(' ');
    String ipValue = '';
    for (String value in splitArray) {
      if (value.contains('addr:')) {
        ipValue = value.replaceFirst('addr:', '');
      }
    }
    return ipValue;
  }

}