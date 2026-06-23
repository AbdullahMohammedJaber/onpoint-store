enum RequestStatus { success, failed, noInternet }

class ApiResult<T> {
  final RequestStatus status;
  final T? data;
  final dynamic message;
  final int? statusCode;

  const ApiResult._({
    required this.status,
    this.data,
    this.message,
    this.statusCode,
  });

  factory ApiResult.success(T data, {int? statusCode, String? message}) {
    return ApiResult._(
      status: RequestStatus.success,
      data: data,
      statusCode: statusCode,
      message: message,
    );
  }

  factory ApiResult.failed({String? message, int? statusCode}) {
    return ApiResult._(
      status: RequestStatus.failed,
      message: message,
      statusCode: statusCode,
    );
  }

  factory ApiResult.noInternet({String? message}) {
    return ApiResult._(status: RequestStatus.noInternet, message: message);
  }

  bool get isSuccess => status == RequestStatus.success;

  bool get isFailed => status == RequestStatus.failed;

  bool get isNoInternet => status == RequestStatus.noInternet;

  void handle({
    required void Function(T data) onSuccess,
    void Function(String message)? onFailed,
    void Function()? onNoInternet,
  }) {
    if (isSuccess && data != null) {
      onSuccess(data!);
    } else if (isFailed) {
      if (onFailed != null) onFailed(message);
    } else if (isNoInternet) {
      if (onNoInternet != null) onNoInternet();
    }
  }
}
