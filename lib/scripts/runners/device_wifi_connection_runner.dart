
import 'package:mobile_controller/model/execute_result.dart';
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';
import 'package:mobile_controller/utils/log_helper.dart';
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
      return SimpleCustomizedStep(stepConfig, (preResult, stepConfig, scriptConfig) async {
        logI('pre step execute result: $preResult');
        if (stepConfig.mark == 'get_ip_addr') {
          return await CommandController.executeAdbCommand(AdbCommand.getIpAddress, runInShell: true);
        } else if (stepConfig.mark == 'wifi_connect') {
          // Get ip address and connect.
          // String cmdExtArgs = scriptConfig.additionalActions![stepConfig.mark]! + ':'
          //     + CommandConfig.defaultConnectionPort;
          if (preResult.succeed) {
            String cmdExtArgs = preResult.result + ':'
                + CommandConfig.defaultConnectionPort;
            var result = await CommandController.executeAdbCommand(AdbCommand.wifiConnection, extArguments: cmdExtArgs);
            return result;
          } else {
            return ExecutionResult.from(stepConfig.mark, false, 'Ip address get failed, runner stopped');
          }

        }
        return await CommandController.executeAdbCommand(AdbCommand.tcpipPortConfig);
      });
    });
  }

  @override
  get stepName => 'wifi_connection_runner';

}