import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/domain/blocs/auth/auth_bloc.dart';
import 'package:bill_share/domain/blocs/auth/auth_event.dart';
import 'package:bill_share/domain/blocs/auth/auth_phone_bloc.dart';
import 'package:bill_share/domain/blocs/auth/auth_state.dart';
import 'package:bill_share/domain/blocs/user/user_bloc.dart';
import 'package:bill_share/domain/blocs/user/user_event.dart';
import 'package:bill_share/domain/blocs/user/user_state.dart';
import 'package:bill_share/domain/models/auth_register_dto.dart';
import 'package:bill_share/domain/models/user_create_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreenCreate extends StatefulWidget {
  const RegisterScreenCreate({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenCreateState();
}

class _RegisterScreenCreateState extends State<RegisterScreenCreate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  AuthPhoneBloc get _authPhoneBloc => context.read<AuthPhoneBloc>();
  AuthBloc get _authBloc => context.read<AuthBloc>();
  UserBloc get _userBloc => context.read<UserBloc>();
  void onRegister() async {
    if (_formKey.currentState!.validate()) {
      _authBloc.add(
        AuthRegisterPressed(
          payload: AuthRegisterDto(
            email: _authPhoneBloc.state.email ?? "",
            password: _authPhoneBloc.state.password ?? "",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == RequestStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error ?? "Something went wrong")),
              );
            } else if (state.status == RequestStatus.success &&
                state.authStatus == AuthStatus.authenticated) {
              _userBloc.add(
                UserInfoCreate(
                  payload: UserCreateDto(
                    username: fullNameController.text,
                    userId: state.user!.uid,
                    phone: _authPhoneBloc.state.phone ?? "",
                    email:
                        state.user?.email ?? _authPhoneBloc.state.email ?? "",
                  ),
                ),
              );
            }
          },
        ),
        BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state.status == RequestStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error ?? "Something went wrong")),
              );
            } else if (state.status == RequestStatus.success &&
                _authBloc.state.authStatus == AuthStatus.authenticated) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Register successful!")));
              context.go('/home');
            }
          },
        ),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(centerTitle: false),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    label: Text("Full name *"),
                    hintText: "Enter full name",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Full name shouldn't be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: onRegister,
                    child: Text("Create Account"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
