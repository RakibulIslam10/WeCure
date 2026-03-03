class ChatTokenModel {
  final bool success;
  final int statusCode;
  final String message;
  final ChatTokenData data;

  ChatTokenModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ChatTokenModel.fromJson(Map<String, dynamic> json) => ChatTokenModel(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: ChatTokenData.fromJson(json["data"]),
  );
}

class ChatTokenData {
  final String appId;
  final String token;
  final int expirationInSeconds;

  ChatTokenData({
    required this.appId,
    required this.token,
    required this.expirationInSeconds,
  });

  factory ChatTokenData.fromJson(Map<String, dynamic> json) => ChatTokenData(
    appId: json["appId"],
    token: json["token"],
    expirationInSeconds: json["expirationInSeconds"],
  );
}