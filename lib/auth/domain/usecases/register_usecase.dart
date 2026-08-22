import 'package:injectable/injectable.dart';
import 'package:nexride/auth/domain/entities/user_entity.dart';
import 'package:nexride/auth/domain/repositories/auth_repository.dart';

@injectable
class RegisterUsecase {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  Future<UserEntity> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repository.registerWithEmail(
      name: name,
      email: email,
      password: password,
    );
  }
}