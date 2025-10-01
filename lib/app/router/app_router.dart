import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:partner/app/presentation/auth/providers/auth_provider.dart';
import 'package:partner/app/presentation/auth/screens/login_screen.dart';
import 'package:partner/app/presentation/auth/screens/register_screen.dart';
import 'package:partner/app/presentation/dashboard/screens/DashboardScreen.dart';
import 'package:partner/app/router/route_constants.dart';



/// Watchable notifier for GoRouter
class AuthRouterNotifier extends ChangeNotifier {
  final Ref ref;
  AuthRouterNotifier(this.ref) {
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = AuthRouterNotifier(ref);

  return GoRouter(
    refreshListenable: authNotifier, // Reactive to auth changes
    initialLocation: RouteConstants.initialRoute,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.user.value != null; // check AsyncValue
      final goingToLogin = state.matchedLocation == RouteConstants.loginRoute;
      final goingToRegister =
          state.matchedLocation == RouteConstants.registerRoute;

      if (!isLoggedIn && !goingToLogin && !goingToRegister) {
        return RouteConstants.loginRoute;
      }

      if (isLoggedIn && (goingToLogin || goingToRegister)) {
        return RouteConstants.dashboardRoute;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RouteConstants.loginRoute,
        builder: (_, __) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteConstants.registerRoute,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteConstants.dashboardRoute,
        builder: (_, __) => const DashboardScreen(),
      ),
    ],
  );
});
