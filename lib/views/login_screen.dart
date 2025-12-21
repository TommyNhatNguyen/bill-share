import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/domain/blocs/auth/login/auth_login_bloc.dart';
import 'package:bill_share/domain/blocs/auth/login/auth_login_event.dart';
import 'package:bill_share/domain/blocs/auth/login/auth_login_state.dart';
import 'package:bill_share/domain/models/auth_login_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthLoginBloc get bloc => context.read<AuthLoginBloc>();
  bool isLoading = true;
  var errorMessage = '';

  void onLogin() async {
    if (_formKey.currentState!.validate()) {
      bloc.add(
        AuthLoginPressed(
          payload: AuthLoginDto(
            email: emailController.text,
            password: passwordController.text,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthLoginBloc, AuthLoginState>(
      listener: (context, state) {
        if (state.status == RequestStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? "Something went wrong")),
          );
        } else if (state.status == RequestStatus.success) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login successful!")));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "Sign in to continue!",
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 250,
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset("assets/logo.png"),
                    ),
                  ),
                  Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.email),
                          label: Text("Email *"),
                          hintText: "Enter email",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email shouldn't be empty";
                          }
                          if (!value.contains("@")) {
                            return "Wrong email format";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          label: Text("Password *"),
                          hintText: "Enter password",
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password shouldn't be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: onLogin,
                          child: Text("Login"),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).go('/register');
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "I'm a new user. ",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text("Sign Up"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
