import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/core/models/result.dart';
import 'package:bill_share/data/services/user_service.dart';
import 'package:bill_share/domain/blocs/user/user_event.dart';
import 'package:bill_share/domain/blocs/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService service = UserService();
  UserBloc() : super(UserState(status: RequestStatus.initial, userInfo: null)) {
    on<UserInfoCreate>(createUserInfo);
  }

  Future<void> createUserInfo(
    UserInfoCreate event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.initial));
    try {
      emit(state.copyWith(status: RequestStatus.loading));
      final result = await service.createUser(event.payload);
      emit(
        state.copyWith(status: RequestStatus.success, userInfo: result.data),
      );
    } on ErrorResult catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          error: e.message,
          userInfo: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          error: e.toString(),
          userInfo: null,
        ),
      );
    }
  }
}
