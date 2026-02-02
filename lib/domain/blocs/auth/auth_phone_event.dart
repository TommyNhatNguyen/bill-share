import 'package:equatable/equatable.dart';

class AuthPhoneEvent extends Equatable {
  const AuthPhoneEvent();
  @override
  List<Object?> get props => [];
}

class AuthPhoneStep1Pressed extends AuthPhoneEvent {
  final String? email;
  final String? password;
  final String? username;
  final String? phone;

  const AuthPhoneStep1Pressed({
    this.email,
    this.password,
    this.username,
    this.phone,
  });

  @override
  List<Object?> get props => [email, password, username, phone];
}
