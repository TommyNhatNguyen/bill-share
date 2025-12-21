import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/data/repositories/auth_repo.dart';
import 'package:bill_share/data/services/result.dart';
import 'package:bill_share/domain/blocs/auth/login/auth_login_event.dart';
import 'package:bill_share/domain/blocs/auth/login/auth_login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthLoginState> {
  final repo = AuthRepoFirebase();
  AuthLoginBloc() : super(const AuthLoginState(status: RequestStatus.initial)) {
    on<AuthLoginPressed>(login);
  }

  Future<void> login(
    AuthLoginPressed event,
    Emitter<AuthLoginState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.initial));
    try {
      emit(state.copyWith(status: RequestStatus.loading));
      final data = await repo.login(event.payload);
      print(data);
      emit(state.copyWith(status: RequestStatus.success));
    } on ErrorResult catch (e) {
      emit(state.copyWith(status: RequestStatus.error, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.error, error: e.toString()));
    }
  }
}
