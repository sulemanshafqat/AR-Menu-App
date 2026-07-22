class UserModel {
  final String uid;
  final String fullName;
  final String email;
  final String phone;
  final String role;
  final String profileImage;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.role,
    required this.profileImage,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'role': role,
      'profileImage': profileImage,
      'createdAt': createdAt,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      fullName: map['fullName'],
      email: map['email'],
      phone: map['phone'],
      role: map['role'],
      profileImage: map['profileImage'],
      createdAt: map['createdAt'].toDate(),
    );
  }
}