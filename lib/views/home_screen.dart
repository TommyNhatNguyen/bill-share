import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/domain/blocs/auth/auth_bloc.dart';
import 'package:bill_share/domain/blocs/auth/auth_event.dart';
import 'package:bill_share/domain/blocs/auth/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() {
      final bloc = context.read<AuthBloc>();
      bloc.add(AuthLogoutPressed());
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == RequestStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? "Something went wrong")),
          );
        } else if (state.status == RequestStatus.success &&
            state.authStatus == AuthStatus.unauthenticated) {
          context.replace('/login');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: Center(
          child: FilledButton(onPressed: logout, child: Text("Logout")),
        ),
      ),
    );
  }
}
