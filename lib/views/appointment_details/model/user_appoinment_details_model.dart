class UserAppointmentDetailsModel {
  final bool success;
  final int statusCode;
  final String message;
  final Data data;

  UserAppointmentDetailsModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UserAppointmentDetailsModel.fromJson(Map<String, dynamic> json) => UserAppointmentDetailsModel(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  final String id;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String appointmentEndTime;
  final String status;
  final int consultationFee;
  final String reasonTitle;
  final String reasonDetails;
  final DoctorInfo doctorInfo;
  final List<Attachment> attachments;
  final DateTime createdAt;

  Data({
    required this.id,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentEndTime,
    required this.status,
    required this.consultationFee,
    required this.reasonTitle,
    required this.reasonDetails,
    required this.doctorInfo,
    required this.attachments,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    appointmentDate: DateTime.parse(json["appointmentDate"]),
    appointmentTime: json["appointmentTime"],
    appointmentEndTime: json["appointmentEndTime"],
    status: json["status"],
    consultationFee: json["consultationFee"],
    reasonTitle: json["reasonTitle"],
    reasonDetails: json["reasonDetails"],
    doctorInfo: DoctorInfo.fromJson(json["doctorInfo"]),
    attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "appointmentDate": appointmentDate.toIso8601String(),
    "appointmentTime": appointmentTime,
    "appointmentEndTime": appointmentEndTime,
    "status": status,
    "consultationFee": consultationFee,
    "reasonTitle": reasonTitle,
    "reasonDetails": reasonDetails,
    "doctorInfo": doctorInfo.toJson(),
    "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
    "createdAt": createdAt.toIso8601String(),
  };
}

class Attachment {
  final String id;
  final String fileKey;
  final String fileType;
  final String url;
  final DateTime createdAt;

  Attachment({
    required this.id,
    required this.fileKey,
    required this.fileType,
    required this.url,
    required this.createdAt,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    id: json["_id"],
    fileKey: json["fileKey"],
    fileType: json["fileType"],
    url: json["url"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fileKey": fileKey,
    "fileType": fileType,
    "url": url,
    "createdAt": createdAt.toIso8601String(),
  };
}

class DoctorInfo {
  final String name;
  final String specialty;
  final String organization;
  final int rating;
  final int totalReviews;
  final int experienceYears;
  final String profileImage;

  DoctorInfo({
    required this.name,
    required this.specialty,
    required this.organization,
    required this.rating,
    required this.totalReviews,
    required this.experienceYears,
    required this.profileImage,
  });

  factory DoctorInfo.fromJson(Map<String, dynamic> json) => DoctorInfo(
    name: json["name"],
    specialty: json["specialty"],
    organization: json["organization"],
    rating: json["rating"],
    totalReviews: json["totalReviews"],
    experienceYears: json["experienceYears"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "specialty": specialty,
    "organization": organization,
    "rating": rating,
    "totalReviews": totalReviews,
    "experienceYears": experienceYears,
    "profileImage": profileImage,
  };
}
