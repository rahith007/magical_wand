class ProfileModel {
  final String fullName;
  final String username;
  final String email;
  final int contact;
  final String password;

  ProfileModel({
    required this.fullName,
    required this.username,
    required this.email,
    required this.contact,
    required this.password,
  });
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      fullName: json['fullname'],
      username: json['username'],
      email: json['email'],
      contact: json['contact'],
      password: json['password'],
    );
  }
}
