import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:partner/app/domain/controllers/auth/auth_controller.dart';
import 'package:partner/app/domain/models/user_model.dart';
import 'package:partner/core/network/api_client.dart';
import 'package:partner/core/providers/storage_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:partner/core/error/exceptions.dart';

/// Auth State
class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final UserModel? user;
  final String? errorMessage;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.user,
    this.errorMessage,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    UserModel? user,
    String? errorMessage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;
  AuthController? _controller;

  AuthNotifier(this._ref) : super(const AuthState()) {
    _init();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);
    try {
      final prefs = await _ref.watch(sharedPreferencesProvider.future);
      final apiClient = ApiClient(); 
      _controller = AuthController(apiClient: apiClient, prefs: prefs);

      // Optionally, check auth status
      final isAuth = await _controller!.isAuthenticated();
      final user = isAuth ? await _controller!.getCurrentUser() : null;
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: isAuth,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> login({required String email, required String password}) async {
    if (_controller == null) return;
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _controller!.login(email: email, password: password);
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (_controller == null) return;
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final user = await _controller!.register(
        name: name,
        email: email,
        password: password,
      );
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: true,
        user: user,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> logout() async {
    if (_controller == null) return;
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      await _controller!.logout();
      state = state.copyWith(
        isLoading: false,
        isAuthenticated: false,
        user: null,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }
}
