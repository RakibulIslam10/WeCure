class CategoryDetailsModel {
  final bool success;
  final int statusCode;
  final String message;
  final List<Specialists> data;
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
    data: List<Specialists>.from(json["data"].map((x) => Specialists.fromJson(x))),
    meta: Meta.fromJson(json["meta"]),
  );
}

class Specialists {
  final String id;
  final String currentOrganization;
  final String specialty;
  final int experienceYears;
  final int totalReviews;
  final String name;
  final String profileImage;
  final int? totalExperienceYears;
  final int? minFee;
  final double averageRating;

  Specialists({
    required this.id,
    required this.currentOrganization,
    required this.specialty,
    required this.experienceYears,
    required this.totalReviews,
     this.minFee,
    required this.name,
    required this.profileImage,
     this.totalExperienceYears,
    required this.averageRating,
  });

  factory Specialists.fromJson(Map<String, dynamic> json) => Specialists(
    id: json["_id"] ?? '',
    currentOrganization: json["currentOrganization"] ?? '',
    specialty: json["specialty"] ?? '',
    experienceYears: json["experienceYears"] ?? 0,
    totalReviews: json["totalReviews"] ?? 0,
    minFee: json["minFee"] ?? 0,
    name: json["name"] ?? '',
    profileImage: json["profileImage"] ?? '',
    totalExperienceYears: json["totalExperienceYears"] ?? 0,
    averageRating: (json["averageRating"] ?? 0).toDouble(),
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
