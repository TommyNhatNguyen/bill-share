import 'package:bill_share/domain/models/auth_login_dto.dart';
import 'package:equatable/equatable.dart';

class AuthLoginEvent extends Equatable {
  const AuthLoginEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginPressed extends AuthLoginEvent {
  final AuthLoginDto payload;

  const AuthLoginPressed({required this.payload});

  @override
  List<Object?> get props => [payload];
}
