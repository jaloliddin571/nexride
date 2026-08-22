import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nexride/auth/domain/usecases/login_usecase.dart';
import 'package:nexride/auth/domain/usecases/register_usecase.dart';
import 'package:nexride/auth/domain/usecases/google_login_usecase.dart';
import 'package:nexride/core/di/injection.dart';
import 'auth_state.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthState build() => const AuthState.initial();

  Future<void> login({required String email, required String password}) async {
    state = const AuthState.loading();
    try {
      final loginUsecase = getIt<LoginUsecase>();
      final user = await loginUsecase(email: email, password: password);
      state = AuthState.success(user);
    } catch (e) {
      state = AuthState.error(_parseError(e.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    try {
      final registerUsecase = getIt<RegisterUsecase>();
      final user = await registerUsecase(name: name, email: email, password: password);
      state = AuthState.success(user);
    } catch (e) {
      state = AuthState.error(_parseError(e.toString()));
    }
  }

  Future<void> loginWithGoogle() async {
    state = const AuthState.loading();
    try {
      final googleLoginUsecase = getIt<GoogleLoginUsecase>();
      final user = await googleLoginUsecase();
      state = AuthState.success(user);
    } catch (e) {
      state = const AuthState.error('Google orqali kirishda xatolik yuz berdi');
    }
  }

  String _parseError(String error) {
    if (error.contains('user-not-found') || error.contains('wrong-password') || error.contains('invalid-credential')) {
      return 'Email yoki parol noto\'g\'ri';
    }
    if (error.contains('invalid-email')) {
      return 'Email formati noto\'g\'ri';
    }
    if (error.contains('email-already-in-use')) {
      return 'Bu email allaqachon ro\'yxatdan o\'tgan';
    }
    if (error.contains('weak-password')) {
      return 'Parol juda oddiy, kuchliroq parol tanlang';
    }
    return 'Xatolik yuz berdi, qaytadan urinib ko\'ring';
  }
}