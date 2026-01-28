import 'package:bill_share/domain/blocs/auth/auth_bloc.dart';
import 'package:bill_share/domain/blocs/user/user_bloc.dart';
import 'package:bill_share/route_configs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
        BlocProvider<UserBloc>(create: (BuildContext context) => UserBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
      ),
    );
  }
}
