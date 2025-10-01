import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:partner/app/domain/models/user_model.dart';
import 'package:partner/core/network/api_client.dart';
import 'package:partner/core/utils/app_utils.dart';
import 'package:partner/core/constants/app_constants.dart';
import 'package:partner/core/error/exceptions.dart';

class AuthController {
  final ApiClient _apiClient;
  final SharedPreferences _prefs;

  AuthController({
    required ApiClient apiClient,
    required SharedPreferences prefs,
  })  : _apiClient = apiClient,
        _prefs = prefs;
        
  // Login
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      if (!await AppUtils.hasNetworkConnection()) {
        throw NetworkException(message: "No internet connection");
      }

      final response = await _apiClient.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      if (response == null || response['user'] == null) {
        throw ServerException(message: "Invalid response from server");
      }

      final user = UserModel.fromJson(response['user']);

      await _prefs.setString(AppConstants.userDataKey, jsonEncode(user.toJson()));
      await _prefs.setString(AppConstants.tokenKey, user.id);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  // Register
  Future<UserModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!await AppUtils.hasNetworkConnection()) {
        throw NetworkException(message: "No internet connection");
      }

      final response = await _apiClient.post(
        '/auth/register',
        data: {'name': name, 'email': email, 'password': password},
      );

      if (response == null || response['user'] == null) {
        throw ServerException(message: "Invalid response from server");
      }

      final user = UserModel.fromJson(response['user']);

      await _prefs.setString(AppConstants.userDataKey, jsonEncode(user.toJson()));
      await _prefs.setString(AppConstants.tokenKey, user.id);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  // Logout
  Future<void> logout() async {
    await _prefs.remove(AppConstants.userDataKey);
    await _prefs.remove(AppConstants.tokenKey);
  }

  // Check authentication
  Future<bool> isAuthenticated() async {
    final token = _prefs.getString(AppConstants.tokenKey);
    return token != null && token.isNotEmpty;
  }

  // Get current user
  Future<UserModel?> getCurrentUser() async {
    final userData = _prefs.getString(AppConstants.userDataKey);
    if (userData == null) return null;
    return UserModel.fromJson(jsonDecode(userData));
  }
}
