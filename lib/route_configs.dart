import 'package:bill_share/views/bills_screen.dart';
import 'package:bill_share/views/home_screen.dart';
import 'package:bill_share/views/login_screen.dart';
import 'package:bill_share/views/register_screen.dart';
import 'package:bill_share/views/split-screen/split_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  // Remove initialLocation completely
  redirect: (context, state) async {
    // final storageService = StorageService();
    // final token = await storageService.storage.read(key: StorageKey.token);
    final token = null;
    // final isLoggedIn = token != null || authState.value != null;
    final isLoggedIn = false;
    final bool isTryingToAccessProtected =
        state.matchedLocation != '/login' &&
        state.matchedLocation != '/register';

    if (!isLoggedIn && isTryingToAccessProtected) {
      return '/login'; // Redirect to login if not logged in and accessing protected route
    } else if (isLoggedIn &&
        (state.matchedLocation == '/login' ||
            state.matchedLocation == '/signup')) {
      return '/home'; // Redirect to home if logged in and trying to access auth pages
    }
    return null; // No redirection needed
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) {
        return LoginScreen();
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
