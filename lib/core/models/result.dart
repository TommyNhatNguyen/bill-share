class SuccessResult<T> {
  final T data;
  SuccessResult({required this.data});
}

class ErrorResult {
  final String message;
  final String? code;

  ErrorResult({required this.message, this.code});
}
