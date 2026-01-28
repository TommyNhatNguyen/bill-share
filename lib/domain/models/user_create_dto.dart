import 'package:equatable/equatable.dart';

class UserCreateDto extends Equatable {
  final String username;
  final String userId;
  final String? phone;
  final String? email;

  const UserCreateDto({
    required this.username,
    required this.userId,
    this.phone,
    this.email,
  });

  factory UserCreateDto.fromJson(Map<String, dynamic> json) {
    return UserCreateDto(
      username: json['username'],
      userId: json['userId'],
      phone: json['phone'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'userId': userId,
      'phone': phone,
      'email': email,
    };
  }

  UserCreateDto copyWith({
    String? username,
    String? userId,
    String? phone,
    String? email,
  }) {
    return UserCreateDto(
      username: username ?? this.username,
      userId: userId ?? this.userId,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }

  @override
  List<Object?> get props => [username, userId, phone, email];
}
