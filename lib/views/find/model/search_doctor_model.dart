import '../../../core/api/end_point/api_end_points.dart';
import '../../../core/api/services/api_request.dart';
import '../../../core/utils/basic_import.dart';

class SearchDoctorModel {
  final String id;
  final String currentOrganization;
  final int experienceYears;
  final int totalReviews;
  final int minFee;
  final String name;
  final String? profileImage;
  final String specialty;
  final int totalExperienceYears;
  final double averageRating;

  SearchDoctorModel({
    required this.id,
    required this.currentOrganization,
    required this.experienceYears,
    required this.totalReviews,
    required this.minFee,
    required this.name,
    this.profileImage,
    required this.specialty,
    required this.totalExperienceYears,
    required this.averageRating,
  });

  factory SearchDoctorModel.fromJson(Map<String, dynamic> json) => SearchDoctorModel(
    id: json["_id"] ?? '',
    currentOrganization: json["currentOrganization"] ?? '',
    experienceYears: json["experienceYears"] ?? 0,
    totalReviews: json["totalReviews"] ?? 0,
    minFee: json["minFee"] ?? 0,
    name: json["name"] ?? '',
    profileImage: json["profileImage"],
    specialty: json["specialty"] ?? '',
    totalExperienceYears: json["totalExperienceYears"] ?? 0,
    averageRating: (json["averageRating"] ?? 0).toDouble(),
  );
}