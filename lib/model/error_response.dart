import 'dart:convert';

class ErrorResponse {
  final String? message;
  final bool? status;

  ErrorResponse({
    this.message,
    this.status,
  });

  factory ErrorResponse.fromRawJson(String str) => ErrorResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "status": status,
  };
}
