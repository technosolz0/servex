class UserCachedModel {
  final int id;
  final String fullName;
  final String email;
  final String mobile;

  UserCachedModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobile,
  });

  static UserCachedModel fromJSON(Map<String, dynamic> json) {
    return UserCachedModel(
      id: json['userId'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'userId': id,
      'fullName': fullName,
      'email': email,
      'mobile': mobile,
    };
  }

  static UserCachedModel initialize() {
    return UserCachedModel(id: 0, fullName: '', email: '', mobile: '');
  }

  UserCachedModel copyWith({
    int? id,
    String? fullName,
    String? email,
    String? mobile,
  }) {
    return UserCachedModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
    );
  }
}
