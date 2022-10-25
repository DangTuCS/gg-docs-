class ErrorModel {
  final String? error;
  final dynamic data;

  ErrorModel({
    required this.error,
    required this.data,
  });

  ErrorModel copyWith({
    String? error,
    dynamic? data,
  }) {
    return ErrorModel(
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}
