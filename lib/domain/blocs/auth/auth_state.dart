import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/core/blocs/base_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState extends BaseState {
  final User? user;
  final AuthStatus authStatus;
  const AuthState({
    required super.status,
    super.error,
    this.user,
    this.authStatus = AuthStatus.unauthenticated,
  });

  AuthState copyWith({
    RequestStatus? status = RequestStatus.initial,
    String? error,
    User? user,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      status: status ?? super.status,
      error: error ?? super.error,
      user: user ?? this.user,
      authStatus: authStatus ?? AuthStatus.unauthenticated,
    );
  }

  @override
  List<Object?> get props => [status, error, user, authStatus];
}
