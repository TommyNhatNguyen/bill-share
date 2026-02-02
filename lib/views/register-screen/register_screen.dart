import 'package:bill_share/domain/blocs/auth/auth_phone_bloc.dart';
import 'package:bill_share/domain/blocs/auth/auth_phone_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthPhoneBloc get _authPhoneBloc => context.read<AuthPhoneBloc>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void onNextStep() async {
    if (_formKey.currentState!.validate()) {
      _authPhoneBloc.add(
        AuthPhoneStep1Pressed(
          email: emailController.text,
          password: emailController.text,
        ),
      );
      context.push('/register/create');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Account",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
            ),
            Text(
              "Sign up to get started!",
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
                        onPressed: onNextStep,
                        child: Text("Next"),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        GoRouter.of(context).go('/login');
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Text("Login"),
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
    );
  }
}
