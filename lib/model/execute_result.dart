
import 'dart:io';

/// Command execution result.
class ExecutionResult {
  ExecutionResult.from(this.command, this.succeed, this.result, {
    this.originData,
  });

  String command = '';
  bool succeed = true;
  ProcessResult? originData;
  dynamic result;

  @override
  String toString() {
    return 'ExecutionResult{ command: $command, succeed: $succeed, '
        'result: ${result.toString()}, originData: $originData}';
  }
}