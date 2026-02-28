class DoctorAppointmentsModel {
  final bool success;
  final int statusCode;
  final String message;
  final List<DoctorAppointments> data;
  final Meta meta;

  DoctorAppointmentsModel({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory DoctorAppointmentsModel.fromJson(Map<String, dynamic> json) =>
      DoctorAppointmentsModel(
        success: json["success"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: List<DoctorAppointments>.from(json["data"].map((x) => DoctorAppointments.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );
}

class DoctorAppointments {
  final String id;
  final DateTime appointmentDate;
  final String appointmentTime;
  final String appointmentEndTime;
  final String status;
  final int consultationFee;
  final String patientName;
  final String specialtyName;

  DoctorAppointments({
    required this.id,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.appointmentEndTime,
    required this.status,
    required this.consultationFee,
    required this.patientName,
    required this.specialtyName,
  });

  factory DoctorAppointments.fromJson(Map<String, dynamic> json) => DoctorAppointments(
    id: json["_id"],
    appointmentDate: DateTime.parse(json["appointmentDate"]),
    appointmentTime: json["appointmentTime"],
    appointmentEndTime: json["appointmentEndTime"],
    status: json["status"],
    consultationFee: json["consultationFee"],
    patientName: json["patientName"],
    specialtyName: json["specialtyName"],
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
