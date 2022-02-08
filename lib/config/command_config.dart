
import 'package:mobile_controller/command/adb/adb_command_executor.dart';
import 'package:mobile_controller/command/adb/customized_command_executor.dart';
import 'package:mobile_controller/command/adb/devices_command_executor.dart';

/// Configs of commands such as adb, sys cmd or java cmd.
/// @author Dorck
/// @date 2022/02/08
class CommandConfig {
  CommandConfig._();

  // Adb commands we used in app.
  static const adbCmdDevList = 'devices';                                   // 已连接的设备列表
  static const adbCmdWirelessConnect = 'connect';                           // 连接WLAN ip
  static const adbCmdWirelessDisconnect = 'disconnect';                     // 断开WLAN连接
  static const adbCmdVersion = 'version';                                   // 查看adb版本信息
  static const adbCmdDeviceModel = 'shell getprop ro.product.model';        // 获取设备型号
  static const adbCmdSysVersion = 'shell getprop ro.build.version.release'; // 查看Android系统版本

  // Instruction and Executor Mapping Table.
  static Map<AdbCommand, AdbCommandExecutor> get adbCommandExecutors => {
    AdbCommand.deviceList: DevicesListCommandExecutor(),

    // Custom command
    AdbCommand.customized: CustomizedAdbCommandExecutor(),
  };
}

/// 提供常见的Abd命令
enum AdbCommand {
  deviceList,
  deviceModel,
  androidSysVersion,
  packageInfo,

  customized
}

class CommandRunException implements Exception {
  CommandRunException({this.message});

  final String? message;

  @override
  String toString() {
    return 'CommandRunException{ message : $message }';
  }
}