import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partner/core/network/api_client.dart';

final apiProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
