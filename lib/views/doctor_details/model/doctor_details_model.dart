class DoctorDetailsInfoModel {
  final bool success;
  final int statusCode;
  final String message;
  final Data data;

  DoctorDetailsInfoModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory DoctorDetailsInfoModel.fromJson(Map<String, dynamic> json) => DoctorDetailsInfoModel(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final Doctor doctor;
  final List<Service> services;
  final List<Experience> experiences;
  final Rating rating;
  final List<Review> reviews;
  final List<Availability> availability;

  Data({
    required this.doctor,
    required this.services,
    required this.experiences,
    required this.rating,
    required this.reviews,
    required this.availability,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    doctor: Doctor.fromJson(json["doctor"]),
    services: List<Service>.from(json["services"].map((x) => Service.fromJson(x))),
    experiences: List<Experience>.from(json["experiences"].map((x) => Experience.fromJson(x))),
    rating: Rating.fromJson(json["rating"]),
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    availability: List<Availability>.from(json["availability"].map((x) => Availability.fromJson(x))),
  );
}

class Availability {
  final String id;
  final String dayOfWeek;
  final String doctorId;
  final int v;
  final DateTime createdAt;
  final String endTime;
  final int fee;
  final bool isActive;
  final int slotSizeMinutes;
  final String startTime;
  final DateTime updatedAt;

  Availability({
    required this.id,
    required this.dayOfWeek,
    required this.doctorId,
    required this.v,
    required this.createdAt,
    required this.endTime,
    required this.fee,
    required this.isActive,
    required this.slotSizeMinutes,
    required this.startTime,
    required this.updatedAt,
  });

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
    id: json["_id"],
    dayOfWeek: json["dayOfWeek"],
    doctorId: json["doctorId"],
    v: json["__v"],
    createdAt: DateTime.parse(json["createdAt"]),
    endTime: json["endTime"],
    fee: json["fee"],
    isActive: json["isActive"],
    slotSizeMinutes: json["slotSizeMinutes"],
    startTime: json["startTime"],
    updatedAt: DateTime.parse(json["updatedAt"]),
  );
}

class Doctor {
  final String id;
  final UserId userId;
  final String currentOrganization;
  final SpecialtyId specialtyId;
  final String about;
  final int consultationFee;
  final String verificationStatus;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String verificationNote;
  final String accountName;
  final String accountNumber;
  final String bankName;
  final String paystackRecipientCode;
  final int pendingPayouts;
  final DateTime recipientCreatedAt;
  final int totalEarnings;
  final int totalPayouts;
  final String dateOfBirth;
  final int experienceYears;
  final int totalExperienceYears;

  Doctor({
    required this.id,
    required this.userId,
    required this.currentOrganization,
    required this.specialtyId,
    required this.about,
    required this.consultationFee,
    required this.verificationStatus,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.verificationNote,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
    required this.paystackRecipientCode,
    required this.pendingPayouts,
    required this.recipientCreatedAt,
    required this.totalEarnings,
    required this.totalPayouts,
    required this.dateOfBirth,
    required this.experienceYears,
    required this.totalExperienceYears,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["_id"],
    userId: UserId.fromJson(json["userId"]),
    currentOrganization: json["currentOrganization"],
    specialtyId: SpecialtyId.fromJson(json["specialtyId"]),
    about: json["about"],
    consultationFee: json["consultationFee"],
    verificationStatus: json["verificationStatus"],
    isVerified: json["isVerified"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    verificationNote: json["verificationNote"],
    accountName: json["accountName"],
    accountNumber: json["accountNumber"],
    bankName: json["bankName"],
    paystackRecipientCode: json["paystackRecipientCode"],
    pendingPayouts: json["pendingPayouts"],
    recipientCreatedAt: DateTime.parse(json["recipientCreatedAt"]),
    totalEarnings: json["totalEarnings"],
    totalPayouts: json["totalPayouts"],
    dateOfBirth: json["dateOfBirth"],
    experienceYears: json["experienceYears"],
    totalExperienceYears: json["totalExperienceYears"],
  );
}

class SpecialtyId {
  final String id;
  final String name;

  SpecialtyId({
    required this.id,
    required this.name,
  });

  factory SpecialtyId.fromJson(Map<String, dynamic> json) => SpecialtyId(
    id: json["_id"],
    name: json["name"],
  );
}

class UserId {
  final String id;
  final String? email;
  final String name;
  final String profileImage;

  UserId({
    required this.id,
    this.email,
    required this.name,
    required this.profileImage,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    email: json["email"],
    name: json["name"],
    profileImage: json["profileImage"],
  );
}

class Experience {
  final String id;
  final String doctorId;
  final String organizationName;
  final String designation;
  final DateTime startDate;
  final DateTime endDate;
  final bool isCurrent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Experience({
    required this.id,
    required this.doctorId,
    required this.organizationName,
    required this.designation,
    required this.startDate,
    required this.endDate,
    required this.isCurrent,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json["_id"],
    doctorId: json["doctorId"],
    organizationName: json["organizationName"],
    designation: json["designation"],
    startDate: DateTime.parse(json["startDate"]),
    endDate: DateTime.parse(json["endDate"]),
    isCurrent: json["isCurrent"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}

class Rating {
  final double average;
  final int total;
  final Map<String, int> breakdown;

  Rating({
    required this.average,
    required this.total,
    required this.breakdown,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    average: json["average"]?.toDouble(),
    total: json["total"],
    breakdown: Map.from(json["breakdown"]).map((k, v) => MapEntry<String, int>(k, v)),
  );
}

class Review {
  final String id;
  final String appointmentId;
  final UserId userId;
  final String doctorId;
  final int rating;
  final String reviewText;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Review({
    required this.id,
    required this.appointmentId,
    required this.userId,
    required this.doctorId,
    required this.rating,
    required this.reviewText,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["_id"],
    appointmentId: json["appointmentId"],
    userId: UserId.fromJson(json["userId"]),
    doctorId: json["doctorId"],
    rating: json["rating"],
    reviewText: json["reviewText"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}

class Service {
  final String id;
  final String doctorId;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Service({
    required this.id,
    required this.doctorId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["_id"],
    doctorId: json["doctorId"],
    name: json["name"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );
}
