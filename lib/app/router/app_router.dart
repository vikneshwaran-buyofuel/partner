import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:partner/app/presentation/auth/providers/auth_provider.dart';
import 'package:partner/app/presentation/auth/screens/login_screen.dart';
import 'package:partner/app/presentation/auth/screens/register_screen.dart';
import 'package:partner/app/presentation/dashboard/screens/DashboardScreen.dart';

class RouteConstants {
  static const loginRoute = '/login';
  static const registerRoute = '/register';
  static const dashboardRoute = '/dashboard';
  static const initialRoute = '/';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteConstants.initialRoute,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.isAuthenticated;
      final goingToLogin = state.matchedLocation == RouteConstants.loginRoute;
      final goingToRegister = state.matchedLocation == RouteConstants.registerRoute;

      if (!isLoggedIn && !goingToLogin && !goingToRegister) {
        return RouteConstants.loginRoute;
      }

      if (isLoggedIn && (goingToLogin || goingToRegister)) {
        return RouteConstants.dashboardRoute;
      }

      return null;
    },
    routes: [
      GoRoute(path: RouteConstants.loginRoute, builder: (_, __) => const LoginScreen()),
      GoRoute(path: RouteConstants.registerRoute, builder: (_, __) => const RegisterScreen()),
      GoRoute(path: RouteConstants.dashboardRoute, builder: (_, __) => const DashboardScreen()),
    ],
  );
});
