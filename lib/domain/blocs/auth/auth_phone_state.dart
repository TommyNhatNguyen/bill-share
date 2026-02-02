import 'package:equatable/equatable.dart';

class AuthPhoneState extends Equatable {
  final String? email;
  final String? password;
  final String? username;
  final String? phone;

  const AuthPhoneState({this.email, this.password, this.username, this.phone});

  AuthPhoneState copyWith({
    String? email,
    String? password,
    String? username,
    String? phone,
  }) {
    return AuthPhoneState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      phone: phone ?? this.phone,
    );
  }

  @override
  List<Object?> get props => [email, password, username, phone];
}
