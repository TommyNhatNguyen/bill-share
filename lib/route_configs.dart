import 'package:bill_share/data/services/firebase_auth_service.dart';
import 'package:bill_share/domain/blocs/auth/login/auth_login_bloc.dart';
import 'package:bill_share/domain/blocs/auth/logout/auth_logout_bloc.dart';
import 'package:bill_share/views/bills_screen.dart';
import 'package:bill_share/views/home_screen.dart';
import 'package:bill_share/views/login_screen.dart';
import 'package:bill_share/views/register_screen.dart';
import 'package:bill_share/views/split-screen/split_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/login',
  // Remove initialLocation completely
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        final authService = FirebaseAuthService();
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => AuthLoginBloc()),
            BlocProvider(create: (context) => AuthLogoutBloc()),
          ],
          child: StreamBuilder(
            stream: authService.firebaseAuth.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text("Loading...");
              }

              if (!snapshot.hasData) {
                return const LoginScreen();
              }

              return const HomeScreen();
            },
          ),
        );
      },
    ),
    GoRoute(path: '/register', builder: (context, state) => RegisterScreen()),
    GoRoute(
      path: '/split-screen',
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          child: SplitScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(
                curve: Curves.easeInOutCirc,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          floatingActionButton: FilledButton.icon(
            onPressed: () {
              GoRouter.of(context).push('/split-screen');
            },
            label: Text(
              "New split",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            icon: Icon(Icons.add_circle_outlined),
          ),
          body: navigationShell,
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: "Bills"),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Account",
              ),
            ],
            currentIndex: navigationShell.currentIndex,
            onTap: (value) {
              navigationShell.goBranch(value);
            },
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/home', builder: (context, state) => HomeScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(path: '/bills', builder: (context, state) => BillsScreen()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/account',
              builder: (context, state) => HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/account',
              builder: (context, state) => HomeScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
