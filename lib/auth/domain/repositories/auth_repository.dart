import 'package:nexride/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  });

  Future<UserEntity> registerWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<UserEntity> loginWithGoogle();

  Future<String> verifyPhoneNumber({
    required String phoneNumber,
  });

  Future<UserEntity> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  });

  Future<void> logout();

  Future<UserEntity?> getCurrentUser();
}