import 'package:injectable/injectable.dart';
import 'package:nexride/auth/domain/entities/user_entity.dart';
import 'package:nexride/auth/domain/repositories/auth_repository.dart';

@injectable
class ConfirmPhoneCodeUsecase {
  final AuthRepository repository;

  ConfirmPhoneCodeUsecase(this.repository);

  Future<UserEntity> call({
    required String verificationId,
    required String smsCode,
  }) {
    return repository.confirmPhoneCode(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }
}