import 'package:flutter/material.dart';

class RegisterScreenCreate extends StatefulWidget {
  const RegisterScreenCreate({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreenCreateState();
}

class _RegisterScreenCreateState extends State<RegisterScreenCreate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();

  void onRegister() async {
    if (_formKey.currentState!.validate()) {
      // bloc.add(
      //   AuthRegisterPressed(
      //     payload: AuthRegisterDto(
      //       email: emailController.text,
      //       password: passwordController.text,
      //     ),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
