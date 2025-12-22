import 'dart:async';

import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/data/repositories/auth_repo.dart';
import 'package:bill_share/data/services/result.dart';
import 'package:bill_share/domain/blocs/auth/auth_event.dart';
import 'package:bill_share/domain/blocs/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  StreamSubscription<User?>? _authSubscription;
  final repo = AuthRepoFirebase();
  AuthBloc()
    : super(
        FirebaseAuth.instance.currentUser == null
            ? const AuthState(
                status: RequestStatus.initial,
                authStatus: AuthStatus.unauthenticated,
                user: null,
              )
            : AuthState(
                status: RequestStatus.initial,
                authStatus: AuthStatus.authenticated,
                user: FirebaseAuth.instance.currentUser,
              ),
      ) {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      add(AuthStateChanged(user: user));
    });
    on<AuthStateChanged>(authChange);
    on<AuthLoginPressed>(login);
    on<AuthRegisterPressed>(register);
    on<AuthLogoutPressed>(logout);
  }

  Future<void> authChange(
    AuthStateChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.initial));
    try {
      if (event.user != null) {
        emit(
          state.copyWith(
            authStatus: AuthStatus.authenticated,
            user: event.user,
          ),
        );
      }
    } on ErrorResult catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          error: e.message,
          authStatus: AuthStatus.unauthenticated,
          user: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          error: e.toString(),
          authStatus: AuthStatus.unauthenticated,
          user: null,
        ),
      );
    }
  }

  Future<void> login(AuthLoginPressed event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: RequestStatus.initial));
    try {
      emit(state.copyWith(status: RequestStatus.loading));
      final data = await repo.login(event.payload);
      emit(
        state.copyWith(
          status: RequestStatus.success,
          authStatus: AuthStatus.authenticated,
          user: data.data.user,
        ),
      );
    } on ErrorResult catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          error: e.message,
          authStatus: AuthStatus.unauthenticated,
          user: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          error: e.toString(),
          authStatus: AuthStatus.unauthenticated,
          user: null,
        ),
      );
    }
  }

  Future<void> register(
    AuthRegisterPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.initial));
    try {
      emit(state.copyWith(status: RequestStatus.loading));
      final data = await repo.register(event.payload);
      emit(
        state.copyWith(
          status: RequestStatus.success,
          authStatus: AuthStatus.authenticated,
          user: data.data.user,
        ),
      );
    } on ErrorResult catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          error: e.message,
          authStatus: AuthStatus.unauthenticated,
          user: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          error: e.toString(),
          authStatus: AuthStatus.unauthenticated,
          user: null,
        ),
      );
    }
  }

  Future<void> logout(AuthLogoutPressed event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: RequestStatus.initial));
    try {
      emit(state.copyWith(status: RequestStatus.loading));
      await repo.logout();
      emit(
        state.copyWith(
          status: RequestStatus.success,
          authStatus: AuthStatus.unauthenticated,
          user: null,
        ),
      );
    } on ErrorResult catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          error: e.message,
          authStatus: AuthStatus.unauthenticated,
          user: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.error,
          error: e.toString(),
          authStatus: AuthStatus.unauthenticated,
          user: null,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
