
import 'package:mobile_controller/model/script_config_data.dart';

/// Temporary data source for inner scripts (includes runner or steps).
/// TODO: Generate data base from config files like yaml or json format.
/// @author Dorck
/// @date 2022/02/14
class TemporaryScriptDataSource {
  TemporaryScriptDataSource._();

  // Auto unlock the screen locker.
  static List<StepConfigModel> generateAutoUnlockStepConfigs() => [
    // Pressing the lock button
    StepConfigModel(
      'key_event',
      additionalAction: '26',
    ),
    // Swipe UP
    StepConfigModel(
      'swipe_distance',
      additionalAction: '640 780 640 480',
    ),
    // Entering your pwd
    StepConfigModel(
      'text_input',
      // TODO: show case a pwd
      additionalAction: '******',
    ),
    // Pressing Enter to confirm
    StepConfigModel(
      'key_event',
      additionalAction: '66',
    ),
  ];
}