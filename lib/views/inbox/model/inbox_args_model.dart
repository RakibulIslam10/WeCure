class InboxArgsModel {
  final String receiverId;
  final String? appointmentId;
  final String? avatar;
  final String? name;

  InboxArgsModel({
    required this.receiverId,
    this.appointmentId,
    this.avatar,
    this.name,
  });

  factory InboxArgsModel.fromMap(Map<String, dynamic> map) {
    return InboxArgsModel(
      receiverId: map['receiverId'] ?? '',
      appointmentId: map['appointmentId'],
      avatar: map['avatar'],
      name: map['name'],
    );
  }
}