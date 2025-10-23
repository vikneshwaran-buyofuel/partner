import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:partner/app/presentation/app_layout/home_layout.dart';
import 'package:partner/app/presentation/auth/providers/auth_provider.dart';
import 'package:partner/app/presentation/auth/screens/create_new_password_page.dart.dart';
import 'package:partner/app/presentation/auth/screens/forgot_password_page.dart';
import 'package:partner/app/presentation/auth/screens/login_page.dart';
import 'package:partner/app/presentation/auth/screens/otp_verification_page.dart';
import 'package:partner/app/presentation/auth/screens/register_screen.dart';
import 'package:partner/app/presentation/app_layout/welcome_page.dart';
import 'package:partner/app/presentation/dashboard/screens/DashboardScreen.dart';
import 'package:partner/app/router/route_constants.dart';

/// Watchable notifier for GoRouter
class AuthRouterNotifier extends ChangeNotifier {
  final Ref ref;
  AuthRouterNotifier(this.ref) {
    // Listen to auth state changes
    ref.listen<AuthState>(authProvider, (_, __) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = AuthRouterNotifier(ref);

  return GoRouter(
    refreshListenable: authNotifier,
    initialLocation: RouteConstants.homeRoute,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isLoggedIn = authState.user.value != null;

      // List of protected routes
      const protectedRoutes = [
        RouteConstants.dashboardRoute,
        RouteConstants.homeRoute,
        RouteConstants.profileRoute,
        RouteConstants.settingsRoute,
        RouteConstants.invoiceDashboardRoute,
        RouteConstants.addInvoiceRoute,
        RouteConstants.viewInvoiceRoute,
        RouteConstants.ledgerDashboardRoute,
        RouteConstants.viewLedgerRoute,
      ];

      // If user not logged in and trying to access a protected route → redirect to login
      // if (!isLoggedIn && protectedRoutes.contains(state.matchedLocation)) {
      //   return RouteConstants.loginRoute;
      // }

      // If user is logged in and trying to access login/register → redirect to dashboard
      // if (isLoggedIn &&
      //     (state.matchedLocation == RouteConstants.loginRoute ||
      //         state.matchedLocation == RouteConstants.registerRoute)) {
      //   return RouteConstants.dashboardRoute;
      // }

      return null; // allow access otherwise
    },
    routes: [
      // Public Routes
      GoRoute(
        path: RouteConstants.splashRoute,
        builder: (_, __) => const WelcomePage(),
      ),
      GoRoute(
        path: RouteConstants.loginRoute,
        builder: (_, __) => const LoginPage(),
      ),
      GoRoute(
        path: RouteConstants.forgotPasswordRoute,
        builder: (_, __) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: RouteConstants.newPasswordRoute,
        builder: (_, __) => const CreateNewPasswordPage(),
      ),
      GoRoute(
        path: RouteConstants.registerRoute,
        builder: (_, __) => const RegisterScreen(),
      ),
      GoRoute(
        path: RouteConstants.otpVerificationRoute,
        builder: (context, state) {
          // You can get passed parameters from `state.extra` or query params
          final email =
              state.extra as String; // assuming you pass it when navigating
          return OtpVerificationPage(email: email);
        },
      ),
       GoRoute(
        path: RouteConstants.homeRoute,
        builder: (_, __) => const HomeLayout(),
      ),
      // Protected Routes
      GoRoute(
        path: RouteConstants.dashboardRoute,
        builder: (_, __) => const DashboardScreen(),
      ),
      GoRoute(
        path: RouteConstants.homeRoute,
        builder: (_, __) =>
            const DashboardScreen(), // replace with HomeScreen if any
      ),
      GoRoute(
        path: RouteConstants.profileRoute,
        builder: (_, __) =>
            const DashboardScreen(), // replace with ProfileScreen
      ),
      GoRoute(
        path: RouteConstants.settingsRoute,
        builder: (_, __) =>
            const DashboardScreen(), // replace with SettingsScreen
      ),
      GoRoute(
        path: RouteConstants.invoiceDashboardRoute,
        builder: (_, __) =>
            const DashboardScreen(), // replace with InvoiceDashboardScreen
      ),
      GoRoute(
        path: RouteConstants.addInvoiceRoute,
        builder: (_, __) =>
            const DashboardScreen(), // replace with AddInvoiceScreen
      ),
      GoRoute(
        path: RouteConstants.viewInvoiceRoute,
        builder: (_, __) =>
            const DashboardScreen(), // replace with ViewInvoiceScreen
      ),
      GoRoute(
        path: RouteConstants.ledgerDashboardRoute,
        builder: (_, __) =>
            const DashboardScreen(), // replace with LedgerDashboardScreen
      ),
      GoRoute(
        path: RouteConstants.viewLedgerRoute,
        builder: (_, __) =>
            const DashboardScreen(), // replace with ViewLedgerScreen
      ),
    ],
  );
});
