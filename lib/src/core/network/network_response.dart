class NetworkResponse<T> {
  T? data;
  String? statusCode;
  bool? success;
  String? statusMessage;

  NetworkResponse({
    this.data,
    this.statusCode,
    this.success,
    this.statusMessage,
  });

  @override
  String toString() {
    return 'ApiResponse<$T>{data: $data, statusCode: $statusCode, success: $success, statusMessage: $statusMessage}';
  }

  factory NetworkResponse.fromError(String message, String statusCode) {
    return NetworkResponse(
      success: false,
      statusCode: statusCode,
      statusMessage: message,
    );
  }
}