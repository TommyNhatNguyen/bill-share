import 'package:equatable/equatable.dart';

class AuthLoginDto extends Equatable {
  final String email;
  final String password;

  const AuthLoginDto({required this.email, required this.password});

  factory AuthLoginDto.fromJson(Map<String, dynamic> json) {
    return AuthLoginDto(
      email: json['email'] ?? json['email'],
      password: json['password'] ?? json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  @override
  List<Object?> get props => [email, password];
}
