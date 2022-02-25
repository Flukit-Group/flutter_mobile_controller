
import 'dart:io';

import 'package:mobile_controller/commands/adb/adb_command_executor.dart';
import 'package:mobile_controller/config/command_config.dart';
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/package_info.dart';

/// Get foreground activity of current device.
/// @author Dorck
/// @date 2022/02/25
class FetchForegroundActivityExecutor extends AdbCommandExecutor {
  @override
  String commandString() {
    return CommandConfig.adbCmdForeWindow;
  }

  @override
  ExecutionResult? processData(ProcessResult originData) {
    // Output e.g., mCurrentFocus=Window{c4cc272 u0 com.tencent.mm/com.tencent.mm.ui.LauncherUI}
    String output = originData.stdout;
    if (output.isNotEmpty && output.contains(_keyword)) {
      var arr = output.split(' ').last.replaceAll('}', '').split('/');
      return success(PackageInfo.brief(arr.first, arr.last));
    } else {
      failure('There is no foreground window displayed.');
    }
  }

  final _keyword = 'mCurrentFocus=Window';

}