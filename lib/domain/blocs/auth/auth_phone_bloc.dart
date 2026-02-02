import 'package:bill_share/domain/blocs/auth/auth_phone_event.dart';
import 'package:bill_share/domain/blocs/auth/auth_phone_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPhoneBloc extends Bloc<AuthPhoneEvent, AuthPhoneState> {
  AuthPhoneBloc() : super(AuthPhoneState()) {
    on<AuthPhoneStep1Pressed>((event, emit) {
      emit(
        state.copyWith(
          email: event.email,
          password: event.password,
          username: event.username,
          phone: event.phone,
        ),
      );
    });
  }
}
