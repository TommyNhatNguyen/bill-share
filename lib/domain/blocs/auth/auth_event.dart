import 'package:bill_share/domain/models/auth_login_dto.dart';
import 'package:bill_share/domain/models/auth_register_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStateChanged extends AuthEvent {
  final User? user;

  const AuthStateChanged({this.user});

  @override
  List<Object?> get props => [user];
}

class AuthLoginPressed extends AuthEvent {
  final AuthLoginDto payload;

  const AuthLoginPressed({required this.payload});

  @override
  List<Object?> get props => [payload];
}

class AuthRegisterPressed extends AuthEvent {
  final AuthRegisterDto payload;

  const AuthRegisterPressed({required this.payload});

  @override
  List<Object?> get props => [payload];
}

class AuthLogoutPressed extends AuthEvent {
  const AuthLogoutPressed();

  @override
  List<Object?> get props => [];
}
