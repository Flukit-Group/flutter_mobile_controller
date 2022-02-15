
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/scripts/runners/device_wifi_connection_runner.dart';
import 'package:mobile_controller/scripts/runners/screen_auto_unlock_runner.dart';
import 'package:mobile_controller/scripts/script_ability.dart';
import '../command/command_controller.dart';
import '../model/script_config_data.dart';
import '../scripts/internal/temporary_script_data_source.dart';

/// The repository of adb scripts.
/// @author Dorck
/// @date 2022/02/13
class AdbScriptsRepository {

  // Connect devices by wifi.
  static Future<ExecutionResult> runWifiDeviceConnection() async {
    List<StepConfigModel> wifiConnectionStepModels = [
      StepConfigModel(
        'listen_tcpip',
      ),
      StepConfigModel(
        'get_ip_addr',
        // We need set a delayed operation to confirm adb gets ready.
        delayTime: const Duration(milliseconds: 2000),
      ),
      StepConfigModel(
        'wifi_connect',
      ),
    ];
    var runnerConfig = RunnerConfigModel('wifi_connection_runner', wifiConnectionStepModels);
    List<Step<ScriptConfigModel>> stepList = [DevWifiConnectionRunner(runnerConfig)];
    return await CommandController.runScript(stepList,
        ScriptConfigModel('build_wifi_connection', additionalActions: {}));
  }

  // Auto unlock the screen.
  static Future<ExecutionResult> runAutoUnlockScreen() async {
    var runnerConfig = RunnerConfigModel('auto_unlock_screen', TemporaryScriptDataSource.generateAutoUnlockStepConfigs());
    List<Step<ScriptConfigModel>> stepList = [ScreenAutoUnlockRunner(runnerConfig)];
    return await CommandController.runScript(stepList,
        ScriptConfigModel('auto_unlock_screen_script', additionalActions: {}));
  }
}