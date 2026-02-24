class PopularDoctorModel {
  final bool success;
  final int statusCode;
  final String message;
  final List<AllDoctors> data;

  PopularDoctorModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory PopularDoctorModel.fromJson(Map<String, dynamic> json) => PopularDoctorModel(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: List<AllDoctors>.from(json["data"].map((x) => AllDoctors.fromJson(x))),
  );
}

class AllDoctors {
  final String id;
  final dynamic currentOrganization;
  final dynamic totalReviews;
  final String name;
  final String profileImage;
  final String specialty;
  final int averageRating;

  AllDoctors({
    required this.id,
    required this.currentOrganization,
    required this.totalReviews,
    required this.name,
    required this.profileImage,
    required this.specialty,
    required this.averageRating,
  });

  factory AllDoctors.fromJson(Map<String, dynamic> json) => AllDoctors(
    id: json["_id"],
    currentOrganization: json["currentOrganization"] ?? '',
    totalReviews: json["totalReviews"] ?? 0,
    name: json["name"] ?? '',
    profileImage: json["profileImage"] ?? '',
    specialty: json["specialty"] ?? '',
    averageRating: json["averageRating"] ?? 0,
  );
}
