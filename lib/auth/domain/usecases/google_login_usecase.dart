import 'package:injectable/injectable.dart';
import 'package:nexride/auth/domain/entities/user_entity.dart';
import 'package:nexride/auth/domain/repositories/auth_repository.dart';

@injectable
class GoogleLoginUsecase {
  final AuthRepository repository;

  GoogleLoginUsecase(this.repository);

  Future<UserEntity> call() {
    return repository.loginWithGoogle();
  }
}