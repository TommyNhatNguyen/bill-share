import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/core/blocs/base_state.dart';
import 'package:bill_share/domain/models/user_model.dart';

class UserState extends BaseState {
  final UserModel? userInfo;

  const UserState({this.userInfo, required super.status, super.error});

  UserState copyWith({
    RequestStatus? status = RequestStatus.initial,
    String? error,
    UserModel? userInfo,
  }) {
    return UserState(
      status: status ?? super.status,
      error: error ?? super.error,
      userInfo: userInfo ?? this.userInfo,
    );
  }

  @override
  List<Object?> get props => [userInfo, status, error];
}
