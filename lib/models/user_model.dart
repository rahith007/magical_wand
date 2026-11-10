class UserModel {
  final String? id;
  final String fullName;
  final String userName;
  final String email;
  final String contactNumber;

  UserModel({
    this.id,
    required this.fullName,
    required this.userName,
    required this.email,
    required this.contactNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      fullName: json['fullName'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      contactNumber: json['contactNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'contactNumber': contactNumber,
    };
  }
}