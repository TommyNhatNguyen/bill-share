import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/data/repositories/auth_repo.dart';
import 'package:bill_share/data/services/result.dart';
import 'package:bill_share/domain/blocs/auth/logout/auth_logout_event.dart';
import 'package:bill_share/domain/blocs/auth/logout/auth_logout_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLogoutBloc extends Bloc<AuthLogoutEvent, AuthLogoutState> {
  final repo = AuthRepoFirebase();
  AuthLogoutBloc()
    : super(const AuthLogoutState(status: RequestStatus.initial)) {
    on<AuthLogoutPressed>(logout);
  }

  Future<void> logout(
    AuthLogoutPressed event,
    Emitter<AuthLogoutState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.initial));
    try {
      emit(state.copyWith(status: RequestStatus.loading));
      await repo.logout();
      emit(state.copyWith(status: RequestStatus.success));
    } on ErrorResult catch (e) {
      emit(state.copyWith(status: RequestStatus.error, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error, error: e.toString()));
    }
  }
}
