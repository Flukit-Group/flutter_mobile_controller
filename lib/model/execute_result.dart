
/// Command execution result.
class ExecutionResult {
  bool error = false;
  dynamic result;

  @override
  String toString() {
    return 'ExecutionResult{ error: $error, result: ${result.toString()}}';
  }
}