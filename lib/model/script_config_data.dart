
/// Middle output result of steps within script.
/// @author Dorck
/// @date 2022/02/10
class ScriptConfigModel {
  String name;
  String? description;
  // TODO: The additional execution parameters of the same command appearing in the script may be different.
  Map<String, String>? additionalActions;

  ScriptConfigModel(this.name, {this.additionalActions, this.description});
}

// Config model of each step executions.
class StepConfigModel {
  String? additionalAction;
  int? timeout;
  Duration? delayTime;
  int? priority;
  String mark;
  bool shouldLoop;
  Duration loopDuration;
  int loopLimit;
  Map<String, dynamic>? ext;
  StepConfigModel? next;

  StepConfigModel(this.mark, {this.additionalAction,
    this.priority,
    this.timeout,
    this.delayTime,
    this.shouldLoop = false,
    this.loopDuration = const Duration(milliseconds: 6000),
    this.loopLimit = -1,
    this.next,
    this.ext,
  });

  @override
  String toString() {
    return 'StepConfigModel{mark:$mark, additionalAction: $additionalAction, '
        'shouldLoop: $shouldLoop, loopDuration: $loopDuration, loopLimit: $loopLimit'
        'priority: $priority, timeout: $timeout, nextConfig: $next'
        '}';
  }
}

/// A combined step contains [children] steps.
/// Note: The configs in children will not take effect if outer [RunnerConfigModel] has already set.
class RunnerConfigModel extends StepConfigModel {
  List<StepConfigModel>? children;
  RunnerConfigModel(String mark, this.children, {
    String? actions,
    int? timeout,
    bool needLoop = false,
    Duration loopDuration = const Duration(milliseconds: 3000),
    int loopLimit = -1,
    int? priority,
  }) : super(mark,
    additionalAction: actions,
    timeout: timeout,
    shouldLoop: needLoop,
    loopDuration: loopDuration,
    loopLimit: loopLimit,
    priority: priority,
  );

}