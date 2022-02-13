
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';
import '../../command/command_controller.dart';
import '../../config/command_config.dart';
import '../script_ability.dart';
import '../steps/simple_customized_step.dart';

/// Runner executor for connecting mobile devices via Wi-Fi.
/// @author Dorck
/// @date 2022/02/13
class DevWifiConnectionRunner extends BaseRunner {
  DevWifiConnectionRunner(RunnerConfigModel runnerConfig) : super(runnerConfig);

  @override
  List<Step<ScriptConfigModel>> childrenSteps() {
    return _getInnerSteps(runnerConfig);
  }

  List<Step<ScriptConfigModel>> _getInnerSteps(RunnerConfigModel runnerConfigModel) {
    var childrenConfigs = runnerConfigModel.children!;
    return List.generate(childrenConfigs.length, (index) {
      var stepConfig = childrenConfigs[index];
      return SimpleCustomizedStep(stepConfig, (stepConfig, scriptConfig) async {
        if (stepConfig.mark == 'get_ip_addr') {
          var result = await CommandController.executeAdbCommand(AdbCommand.getIpAddress);
          if (result.succeed) {
            // Pass the parameter with the return value to the next step.
            scriptConfig.additionalActions!['wifi_connect'] = result.result.toString();
            return result;
          }
        } else if (stepConfig.mark == 'wifi_connect') {
          // Get ip address and connect.
          String cmdExtArgs = scriptConfig.additionalActions![stepConfig.mark]! + ':'
              + CommandConfig.defaultConnectionPort;
          var result = await CommandController.executeAdbCommand(AdbCommand.wifiConnection, extArguments: cmdExtArgs);
          return result;
        }
        return CommandController.executeAdbCommand(AdbCommand.tcpipPortConfig);
      });
    });
  }

  @override
  get stepName => 'wifi_connection_runner';

}