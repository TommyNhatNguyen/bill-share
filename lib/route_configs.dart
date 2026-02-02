import 'package:bill_share/constants/enums.dart';
import 'package:bill_share/domain/blocs/auth/auth_bloc.dart';
import 'package:bill_share/views/bills_screen.dart';
import 'package:bill_share/views/home_screen.dart';
import 'package:bill_share/views/login_screen.dart';
import 'package:bill_share/views/register-screen/register_screen.dart';
import 'package:bill_share/views/register-screen/register_screen_create.dart';
import 'package:bill_share/views/split-screen/split_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    final isLogin =
        context.read<AuthBloc>().state.authStatus == AuthStatus.authenticated;
    if (isLogin &&
        (state.uri.toString() == '/login' ||
            state.uri.toString() == '/register')) {
      return '/home';
    }

    return null;
  },
  routes: [
    GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
      routes: [
        GoRoute(
          path: 'create',
          builder: (context, state) => const RegisterScreenCreate(),
        ),
      ],
    ),
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
