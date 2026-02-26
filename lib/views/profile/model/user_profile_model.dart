class UserProfileModel {
  final bool success;
  final int statusCode;
  final String message;
  final UserData data;

  UserProfileModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    success: json["success"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: UserData.fromJson(json["data"]),
  );

}

class UserData {
  final String id;
  final String email;
  final int v;
  final DateTime createdAt;
  final dynamic emailVerificationOtp;
  final dynamic emailVerificationOtpExpires;
  final bool isEmailVerified;
  final String name;
  final String role;
  final String status;
  final DateTime updatedAt;
  final String refreshToken;
  final DateTime dateOfBirth;
  final String phone;
  final String profileImage;
  final dynamic passwordResetOtp;
  final dynamic passwordResetOtpExpires;
  final String bloodGroup;
  final List<String> allergies;
  final String accountName;
  final String accountNumber;
  final String bankName;

  UserData({
    required this.id,
    required this.email,
    required this.v,
    required this.createdAt,
    required this.emailVerificationOtp,
    required this.emailVerificationOtpExpires,
    required this.isEmailVerified,
    required this.name,
    required this.role,
    required this.status,
    required this.updatedAt,
    required this.refreshToken,
    required this.dateOfBirth,
    required this.phone,
    required this.profileImage,
    required this.passwordResetOtp,
    required this.passwordResetOtpExpires,
    required this.bloodGroup,
    required this.allergies,
    required this.accountName,
    required this.accountNumber,
    required this.bankName,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    email: json["email"],
    v: json["__v"],
    createdAt: DateTime.parse(json["createdAt"]),
    emailVerificationOtp: json["emailVerificationOtp"],
    emailVerificationOtpExpires: json["emailVerificationOtpExpires"],
    isEmailVerified: json["isEmailVerified"],
    name: json["name"],
    role: json["role"],
    status: json["status"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    refreshToken: json["refreshToken"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    phone: json["phone"],
    profileImage: json["profileImage"],
    passwordResetOtp: json["passwordResetOtp"],
    passwordResetOtpExpires: json["passwordResetOtpExpires"],
    bloodGroup: json["bloodGroup"],
    allergies: List<String>.from(json["allergies"].map((x) => x)),
    accountName: json["accountName"],
    accountNumber: json["accountNumber"],
    bankName: json["bankName"],
  );

}
