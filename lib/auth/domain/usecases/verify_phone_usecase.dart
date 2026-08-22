import 'package:injectable/injectable.dart';
import 'package:nexride/auth/domain/repositories/auth_repository.dart';

@injectable
class VerifyPhoneUsecase {
  final AuthRepository repository;

  VerifyPhoneUsecase(this.repository);

  Future<String> call({required String phoneNumber}) {
    return repository.verifyPhoneNumber(phoneNumber: phoneNumber);
  }
}