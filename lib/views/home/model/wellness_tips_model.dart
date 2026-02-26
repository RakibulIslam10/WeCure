class WellnessTipModel {
  final bool success;
  final int statusCode;
  final String message;
  final List<AllTips> allTips;
  final Meta meta;

  WellnessTipModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.allTips,
    required this.meta,
  });

  factory WellnessTipModel.fromJson(Map<String, dynamic> json) =>
      WellnessTipModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        allTips: List<AllTips>.from(
          json["data"].map((x) => AllTips.fromJson(x)),
        ),
        meta: Meta.fromJson(json["meta"]),
      );
}

class AllTips {
  final String id;
  final String content;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
   bool isFavourite;

  AllTips({
    required this.id,
    required this.content,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.isFavourite,
  });

  factory AllTips.fromJson(Map<String, dynamic> json) => AllTips(
    id: json["_id"],
    content: json["content"],
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isFavourite: json["isFavourite"],
  );
}

class Meta {
  final int total;
  final int page;
  final int limit;

  Meta({required this.total, required this.page, required this.limit});

  factory Meta.fromJson(Map<String, dynamic> json) =>
      Meta(total: json["total"], page: json["page"], limit: json["limit"]);
}
