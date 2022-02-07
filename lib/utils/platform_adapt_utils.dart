
import 'dart:convert';
import 'dart:io';
import 'package:mobile_controller/config/common_config.dart';
import 'package:mobile_controller/config/file_config.dart';
import 'package:mobile_controller/utils/log_helper.dart';
/// Adapter for different platforms of adb command executor.
/// @author dorck
/// @date 2022/02/07
class PlatformAdaptUtils {
  static String getLineBreak() {
    if (Platform.isWindows) {
      return "\r\n";
    } else {
      return "\n";
    }
  }

  ///windows和linux系统的命令行指令不一样
  ///使用run命令拿到的输出结果总是在运行完成了才全部输出
  static Future<ProcessResult> runCommand(String commandStr,
      {bool runInShell = true,
        String? workDirectory,
        bool isAdbCommand = false}) {
    if (isAdbCommand) {
      commandStr = adbCommand(commandStr);
    }
    commandStr = javaCommand(commandStr);
    if (Platform.isMacOS || Platform.isLinux) {
      String executable = commandStr.split(" ")[0];
      List<String> arguments =
      commandStr.replaceFirst(executable, "").trim().split(" ");
      return Process.run(executable, arguments,
          runInShell: runInShell,
          workingDirectory: workDirectory,
          stdoutEncoding: Encoding.getByName("utf-8"));
    } else {
      return Process.run(commandStr, [],
          runInShell: runInShell,
          workingDirectory: workDirectory,
          stdoutEncoding: Encoding.getByName("utf-8"));
    }
  }

  static String grepFindStr() {
    if (Platform.isWindows) {
      return "findstr";
    }
    return "grep";
  }

  /// ProcessStartMode 可以设置开启进程模式，但是我测试没成功，没法重定向输出流到我的文本上面来
  static Future<Process> startCommand(String commandStr,
      {bool runInShell = true,
        String? workDirectory,
        ProcessStartMode mode = ProcessStartMode.normal}) {
    commandStr = javaCommand(commandStr);
    logV(commandStr);
    if (Platform.isMacOS || Platform.isLinux) {
      String executable = commandStr.split(" ")[0];
      List<String> arguments =
      commandStr.replaceFirst(executable, "").trim().split(" ");
      return Process.start(executable, arguments,
          runInShell: runInShell, workingDirectory: workDirectory, mode: mode);
    } else {
      return Process.start(commandStr, [],
          runInShell: runInShell, workingDirectory: workDirectory, mode: mode);
    }
  }

  static String javaCommand(String command) {
    if (!command.startsWith("java")) {
      return command;
    }
    if (FileConfig.javaPath.isNotEmpty) {
      return command.replaceFirst("java", FileConfig.javaPath);
    }
    return command;
  }

  /// TODO: support multi devices execute cmd at same time.
  static String adbCommand(String command) {
    return adbCommandFrom(command, device: CommonConfig.currentAndroidDevice);
  }

  // Execute command of single device.
  static String adbCommandFrom(String command, {required String device}) {
    if (!command.startsWith("adb")) {
      if (device.isNotEmpty) {
        return FileConfig.adbPath +
            " -s " +
            device +
            " " +
            command;
      }
      return FileConfig.adbPath + " " + command;
    }
    if (FileConfig.javaPath.isNotEmpty) {
      if (device.isNotEmpty) {
        return FileConfig.adbPath +
            " -s " +
            device +
            " " +
            command.replaceFirst("adb", "");
      }
      return command.replaceFirst("adb", FileConfig.adbPath);
    }
    return command;
  }

  static String getSeparator() {
    if (Platform.isWindows) {
      return r"\";
    }
    return r"/";
  }
}
