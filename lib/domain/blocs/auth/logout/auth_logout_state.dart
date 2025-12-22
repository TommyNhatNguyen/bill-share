import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/core/blocs/base_state.dart';

class AuthLogoutState extends BaseState {
  const AuthLogoutState({required super.status, super.error});

  AuthLogoutState copyWith({
    RequestStatus? status = RequestStatus.initial,
    String? error,
  }) {
    return AuthLogoutState(status: status ?? super.status, error: error);
  }

  @override
  List<Object?> get props => [status, error];
}
