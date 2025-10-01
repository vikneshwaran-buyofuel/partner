import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:partner/app/domain/controllers/auth/auth_controller.dart';
import 'package:partner/app/domain/models/user_model.dart';
import 'package:partner/app/providers/api_provider.dart';
import 'package:partner/app/providers/storage_providers.dart';

/// --------------------
/// Auth State
/// --------------------
class AuthState {
  final AsyncValue<UserModel?> user;

  const AuthState({this.user = const AsyncValue.data(null)});

  AuthState copyWith({AsyncValue<UserModel?>? user}) {
    return AuthState(user: user ?? this.user);
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;
  AuthController? _controller;
  AuthNotifier(this._ref) : super(const AuthState()) {
    _init();
  }

  Future<void> _init() async {
    // Show loading
    state = state.copyWith(user: const AsyncValue.loading());
    try {
      final prefs = await _ref.watch(sharedPreferencesProvider.future);
      final apiClient = _ref.read(apiProvider);
      _controller = AuthController(apiClient: apiClient, prefs: prefs);

      final isAuth = await _controller!.isAuthenticated();
      final currentUser =
          isAuth ? await _controller!.getCurrentUser() : null;

      state = state.copyWith(
          user: AsyncValue.data(currentUser));
    } catch (e, st) {
      state = state.copyWith(user: AsyncValue.error(e, st));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (_controller == null) return;
    state = state.copyWith(user: const AsyncValue.loading());
    try {
      final user = await _controller!.login(email: email, password: password);
      state = state.copyWith(user: AsyncValue.data(user));
    } catch (e, st) {
      state = state.copyWith(user: AsyncValue.error(e, st));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (_controller == null) return;
    state = state.copyWith(user: const AsyncValue.loading());
    try {
      final user = await _controller!.register(
        name: name,
        email: email,
        password: password,
      );
      state = state.copyWith(user: AsyncValue.data(user));
    } catch (e, st) {
      state = state.copyWith(user: AsyncValue.error(e, st));
    }
  }

  Future<void> logout() async {
    if (_controller == null) return;
    state = state.copyWith(user: const AsyncValue.loading());
    try {
      await _controller!.logout();
      state = state.copyWith(user: const AsyncValue.data(null));
    } catch (e, st) {
      state = state.copyWith(user: AsyncValue.error(e, st));
    }
  }
}

/// --------------------
/// Auth Provider
/// --------------------
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
