import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/core/blocs/base_state.dart';

class AuthLoginState extends BaseState {
  const AuthLoginState({required super.status, super.error});

  AuthLoginState copyWith({
    RequestStatus? status = RequestStatus.initial,
    String? error,
  }) {
    return AuthLoginState(status: status ?? super.status, error: error);
  }

  @override
  List<Object?> get props => [status, error];
}
