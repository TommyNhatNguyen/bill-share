import 'package:bill_share/domain/blocs/auth/logout/auth_logout_bloc.dart';
import 'package:bill_share/domain/blocs/auth/logout/auth_logout_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void logout() {
      final bloc = context.read<AuthLogoutBloc>();
      bloc.add(AuthLogoutPressed());
    }

    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: FilledButton(onPressed: logout, child: Text("Logout")),
      ),
    );
  }
}
