class PopularSpecialitesModel {
  final bool success;
  final int statusCode;
  final String message;
  final List<Specialities> data;
  final Meta meta;

  PopularSpecialitesModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory PopularSpecialitesModel.fromJson(Map<String, dynamic> json) => PopularSpecialitesModel(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<Specialities>.from(json["data"].map((x) => Specialities.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

}

class Specialities {
  final String id;
  final String name;
  final String description;
  final dynamic thumbnail;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Specialities({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnail,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Specialities.fromJson(Map<String, dynamic> json) => Specialities(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    thumbnail: json["thumbnail"] ?? '',
    isActive: json["isActive"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

}

class Meta {
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  Meta({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
    totalPages: json["totalPages"],
  );

}
