// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:nexride/auth/data/datasources/auth_remote_datasource.dart'
    as _i496;
import 'package:nexride/auth/data/datasources/auth_repository_impl.dart'
    as _i174;
import 'package:nexride/auth/domain/repositories/auth_repository.dart' as _i828;
import 'package:nexride/auth/domain/usecases/confirm_phone_code_usecase.dart'
    as _i33;
import 'package:nexride/auth/domain/usecases/google_login_usecase.dart' as _i45;
import 'package:nexride/auth/domain/usecases/login_usecase.dart' as _i22;
import 'package:nexride/auth/domain/usecases/register_usecase.dart' as _i351;
import 'package:nexride/auth/domain/usecases/verify_phone_usecase.dart'
    as _i747;
import 'package:nexride/core/di/register_module.dart' as _i357;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.lazySingleton<_i496.AuthRemoteDatasource>(
        () => _i496.AuthRemoteDatasourceImpl(
              firebaseAuth: gh<_i59.FirebaseAuth>(),
              googleSignIn: gh<_i116.GoogleSignIn>(),
            ));
    gh.lazySingleton<_i828.AuthRepository>(
        () => _i174.AuthRepositoryImpl(gh<_i496.AuthRemoteDatasource>()));
    gh.factory<_i33.ConfirmPhoneCodeUsecase>(
        () => _i33.ConfirmPhoneCodeUsecase(gh<_i828.AuthRepository>()));
    gh.factory<_i45.GoogleLoginUsecase>(
        () => _i45.GoogleLoginUsecase(gh<_i828.AuthRepository>()));
    gh.factory<_i22.LoginUsecase>(
        () => _i22.LoginUsecase(gh<_i828.AuthRepository>()));
    gh.factory<_i351.RegisterUsecase>(
        () => _i351.RegisterUsecase(gh<_i828.AuthRepository>()));
    gh.factory<_i747.VerifyPhoneUsecase>(
        () => _i747.VerifyPhoneUsecase(gh<_i828.AuthRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i357.RegisterModule {}
