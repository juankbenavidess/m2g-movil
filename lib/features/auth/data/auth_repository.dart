import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/api_config.dart';
import '../../../core/network/dio_client.dart';
import '../../../core/storage/secure_storage_service.dart';
import 'models/user_model.dart';

class AuthRepository {
  final DioClient _dioClient;
  final SecureStorageService _storage;

  AuthRepository(this._dioClient, this._storage);

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiConfig.loginEndpoint,
        data: {'email': email, 'password': password},
      );

      final user = UserModel.fromJson(response.data['data']['user']);

      final token = response.data['data']['token'] as String;

      // Save token and user data
      await _storage.saveToken(token);
      await _storage.saveUserId(user.id);
      await _storage.saveUserEmail(user.email);

      return user.copyWith(token: token);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storage.clearAll();
  }

  Future<bool> isLoggedIn() async {
    return await _storage.isLoggedIn();
  }

  Future<UserModel?> getCurrentUser() async {
    final token = await _storage.getToken();
    final userId = await _storage.getUserId();
    final email = await _storage.getUserEmail();

    if (token != null && userId != null && email != null) {
      return UserModel(
        id: userId,
        email: email,
        name: email.split('@')[0], // Fallback name
        token: token,
      );
    }

    return null;
  }
}

// Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final storage = ref.watch(secureStorageServiceProvider);
  return AuthRepository(dioClient, storage);
});
