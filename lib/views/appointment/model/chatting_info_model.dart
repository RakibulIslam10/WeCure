class ChattingInfoModel {
  final bool success;
  final int statusCode;
  final String message;
  final String conversationId;
  final Recipient recipient;

  ChattingInfoModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.conversationId,
    required this.recipient,
  });

  factory ChattingInfoModel.fromJson(Map<String, dynamic> json) => ChattingInfoModel(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    conversationId: json["conversationId"],
    recipient: Recipient.fromJson(json["recipient"]),
  );
}

class Recipient {
  final String id;
  final String role;
  final String name;
  final String image;

  Recipient({
    required this.id,
    required this.role,
    required this.name,
    required this.image,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
    id: json["id"],
    role: json["role"],
    name: json["name"],
    image: json["image"],
  );
}
