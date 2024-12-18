class GeneralResponse {
  GeneralResponse({
    required this.message,
    required this.errorCode,
    required this.errorMessage,
  });

  final String message;
  final String errorCode;
  final String errorMessage;

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(
        message: json["message"] ?? '',
        errorCode: json["errorCode"] ?? '',
        errorMessage: json["errorMessage"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errorCode": errorCode,
        "errorMessage": errorMessage
      };
}
