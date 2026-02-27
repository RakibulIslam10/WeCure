// To parse this JSON data, do
//
//     final categoryDetailsModel = categoryDetailsModelFromJson(jsonString);

import 'dart:convert';

CategoryDetailsModel categoryDetailsModelFromJson(String str) => CategoryDetailsModel.fromJson(json.decode(str));

String categoryDetailsModelToJson(CategoryDetailsModel data) => json.encode(data.toJson());

class CategoryDetailsModel {
  final bool success;
  final int statusCode;
  final String message;
  final List<Datum> data;
  final Meta meta;

  CategoryDetailsModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory CategoryDetailsModel.fromJson(Map<String, dynamic> json) => CategoryDetailsModel(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "statusCode": statusCode,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "meta": meta.toJson(),
  };
}

class Datum {
  final String id;
  final String currentOrganization;
  final int experienceYears;
  final int totalReviews;
  final int minFee;
  final String name;
  final String profileImage;
  final int totalExperienceYears;
  final double averageRating;

  Datum({
    required this.id,
    required this.currentOrganization,
    required this.experienceYears,
    required this.totalReviews,
    required this.minFee,
    required this.name,
    required this.profileImage,
    required this.totalExperienceYears,
    required this.averageRating,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    currentOrganization: json["currentOrganization"],
    experienceYears: json["experienceYears"],
    totalReviews: json["totalReviews"],
    minFee: json["minFee"],
    name: json["name"],
    profileImage: json["profileImage"],
    totalExperienceYears: json["totalExperienceYears"],
    averageRating: json["averageRating"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "currentOrganization": currentOrganization,
    "experienceYears": experienceYears,
    "totalReviews": totalReviews,
    "minFee": minFee,
    "name": name,
    "profileImage": profileImage,
    "totalExperienceYears": totalExperienceYears,
    "averageRating": averageRating,
  };
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

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };
}
