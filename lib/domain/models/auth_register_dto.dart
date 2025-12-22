import 'package:equatable/equatable.dart';

class AuthRegisterDto extends Equatable {
  final String email;
  final String password;

  const AuthRegisterDto({required this.email, required this.password});

  factory AuthRegisterDto.fromJson(Map<String, dynamic> json) {
    return AuthRegisterDto(
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
