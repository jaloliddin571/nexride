import 'package:injectable/injectable.dart';
import 'package:nexride/auth/data/datasources/auth_remote_datasource.dart';
import 'package:nexride/auth/domain/entities/user_entity.dart';
import 'package:nexride/auth/domain/repositories/auth_repository.dart';

import '../models/user_model.dart';
@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.remoteDatasource);

  @override
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final userModel = await remoteDatasource.loginWithEmail(
      email: email,
      password: password,
    );
    return userModel.toEntity();
  }

  @override
  Future<UserEntity> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    final userModel = await remoteDatasource.registerWithEmail(
      name: name,
      email: email,
      password: password,
    );
    return userModel.toEntity();
  }

  @override
  Future<UserEntity> loginWithGoogle() async {
    final userModel = await remoteDatasource.loginWithGoogle();
    return userModel.toEntity();
  }

  @override
  Future<String> verifyPhoneNumber({required String phoneNumber}) {
    return remoteDatasource.verifyPhoneNumber(phoneNumber: phoneNumber);
  }

  @override
  Future<UserEntity> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final userModel = await remoteDatasource.confirmPhoneCode(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return userModel.toEntity();
  }

  @override
  Future<void> logout() {
    return remoteDatasource.logout();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userModel = await remoteDatasource.getCurrentUser();
    return userModel?.toEntity();
  }
}