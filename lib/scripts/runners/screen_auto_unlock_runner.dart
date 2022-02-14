
import 'package:mobile_controller/model/script_config_data.dart';
import 'package:mobile_controller/repository/common_repository.dart';
import 'package:mobile_controller/scripts/script_ability.dart';
import 'package:mobile_controller/scripts/steps/base_step.dart';

/// A micro script runner to auto unlock the screen.
/// @author Dorck
/// @date 2022/02/14
class ScreenAutoUnlockRunner extends BaseRunner {
  ScreenAutoUnlockRunner(RunnerConfigModel runnerConfig) : super(runnerConfig);

  @override
  List<Step<ScriptConfigModel>> childrenSteps() {
    return CommonDataRepository.generateSteps(runnerConfig.children!);
  }

  @override
  get stepName => 'auto_unlock_screen';

}