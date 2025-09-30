// storage_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../storage/local_storage_service.dart';

/// SharedPreferences instance
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});


/// LocalStorageService instance
final localStorageServiceProvider = FutureProvider<LocalStorageService>((ref) async {
  final prefs = await ref.watch(sharedPreferencesProvider.future);
  return LocalStorageService(prefs);
});
