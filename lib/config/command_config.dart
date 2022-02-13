
import 'package:mobile_controller/command/adb/adb_command_executor.dart';
import 'package:mobile_controller/command/adb/customized_cmd_executor.dart';
import 'package:mobile_controller/command/adb/devices_list_cmd_executor.dart';
import 'package:mobile_controller/command/adb/ip_address_cmd_executor.dart';
import 'package:mobile_controller/command/adb/tcpip_listener_cmd_executor.dart';
import 'package:mobile_controller/command/adb/wifi_connect_cmd_executor.dart';

/// Configs of commands such as adb, sys cmd or java cmd.
/// @author Dorck
/// @date 2022/02/08
class CommandConfig {
  CommandConfig._();

  // Adb commands we used in app.
  static const adbCmdDevList = 'devices -l';                                // 已连接的设备列表
  static const adbCmdVersion = 'version';                                   // 查看adb版本信息
  static const adbCmdDeviceModel = 'shell getprop ro.product.model';        // 获取设备型号
  static const adbCmdSysVersion = 'shell getprop ro.build.version.release'; // 查看Android系统版本


  // Query ip address of WLAN.
  static const defaultConnectionPort = '5555';
  static const adbCmdWlanIpAddress = 'shell ifconfig wlan0';
  // Listen for tcpip connections on port `5555`.
  static const adbCmdTcpIpPortListen = 'tcpip 5555';
  // 连接WLAN ip. e.g. adb connect xx(ip addr):5555
  static const adbCmdWirelessConnect = 'connect';
  // 断开WLAN连接
  static const adbCmdWirelessDisconnect = 'disconnect';
  // 查看前台应用的当前页面所属 Activity
  static const adbCmdCurActivity = 'shell dumpsys activity top | grep ACTIVITY';
  // 启动某个应用下的 Activity. e.g., `adb shell am start com.tencent.mm/.ui.LauncherUI`
  static const adbCmdLaunchAppActivity = 'shell am start';
  // 模拟点击操作 e.g., `adb shell input tap 100 100`
  static const adbCmdInputTap = 'shell input tap';
  // 模拟文本输入 (问题：无法输入中文)
  static const adbCmdInputText = 'shell input text';
  // 模拟键盘按键触发
  static const adbCmdInputKeyboard = 'shell input keyevent';
  // 模拟文本输入 (适配中文) solution see: https://github.com/senzhk/ADBKeyBoard
  static const adbCmdInputTextByBroadcast = 'shell am broadcast -a ADB_INPUT_TEXT --es msg';
  // 判断apk是否安装
  static const adbCmdPackageIsInstalled = 'adb shell pm list packages';
  // 拾取用户点击手机屏幕的位置坐标 e.g.
  // /dev/input/event4: 0003 0035 000002c1 (x)
  // /dev/input/event4: 0003 0036 0000091e (y)
  static const adbCmdRecordTapPosition = 'getevent -c 10';

  // Instruction and Executor Mapping Table.
  static Map<AdbCommand, AdbCommandExecutor> get adbCommandExecutors => {
    AdbCommand.deviceList: DevicesListCommandExecutor(),
    AdbCommand.tcpipPortConfig: TcpipListenerCommandExecutor(),
    AdbCommand.getIpAddress: IpAddressCommandExecutor(),
    AdbCommand.wifiConnection: WifiConnectionCmdExecutor(),
    // Custom command
    AdbCommand.customized: CustomizedAdbCommandExecutor(),
  };
}

/// 提供常见的Abd命令
enum AdbCommand {
  deviceList,
  tcpipPortConfig,
  getIpAddress,
  wifiConnection,
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