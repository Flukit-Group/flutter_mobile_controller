
/// Middle output result of steps within script.
/// @author Dorck
/// @date 2022/02/10
class ScriptConfigModel {
  String name;
  String? description;
  Map<String, StepConfigModel> stepConfigs;

  ScriptConfigModel(this.name, this.stepConfigs, {this.description});
}

// Config model of each step executions.
class StepConfigModel {
  String? additionalAction;
  int? timeout;
  int? delayTime;
  int? priority;
  String mark;
  bool shouldLoop;
  Duration loopDuration;
  int loopLimit;

  StepConfigModel(this.mark, {this.additionalAction,
    this.priority,
    this.timeout,
    this.delayTime,
    this.shouldLoop = false,
    this.loopDuration = const Duration(milliseconds: 6000),
    this.loopLimit = -1,
  });
}