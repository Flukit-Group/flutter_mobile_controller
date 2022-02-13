
import 'dart:io';

import 'package:mobile_controller/command/adb/adb_command_executor.dart';
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/utils/log_helper.dart';

/// Set the target device to listen for TCP/IP connections on port 5555.
/// @author Dorck
/// @date 2022/02/13
class TcpipListenerCommandExecutor extends AdbCommandExecutor {
  @override
  String commandString() {
    return CommandConfig.adbCmdTcpIpPortListen;
  }

  @override
  ExecutionResult? processData(ProcessResult originData) {
    // result format: restarting in TCP mode port: 5555
    String output = originData.stdout;
    if (output.contains('restarting in TCP mode port: 5555')) {
      return success('Listening port: 5555');
    } else {
      return failure('Can not listen tcpip port: 5555');
    }
  }

}