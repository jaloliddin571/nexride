import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:nexride/auth/data/models/user_model.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel> registerWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithGoogle();

  Future<String> verifyPhoneNumber({required String phoneNumber});

  Future<UserModel> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  });

  Future<void> logout();

  Future<UserModel?> getCurrentUser();
}

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  AuthRemoteDatasourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

  // Firebase User obyektini bizning UserModel'ga aylantiruvchi yordamchi metod
  UserModel _mapFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      phoneNumber: user.phoneNumber,
      photoUrl: user.photoURL,
    );
  }

  @override
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _mapFirebaseUser(credential.user!);
  }

  @override
  Future<UserModel> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Ro'yxatdan o'tgach, ismni profile'ga yozib qo'yamiz
    await credential.user!.updateDisplayName(name);
    await credential.user!.reload();

    final updatedUser = firebaseAuth.currentUser!;
    return _mapFirebaseUser(updatedUser);
  }

  @override
  Future<UserModel> loginWithGoogle() async {
    final googleUser = await googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception('Google Sign-In bekor qilindi');
    }

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    return _mapFirebaseUser(userCredential.user!);
  }

  @override
  Future<String> verifyPhoneNumber({required String phoneNumber}) async {
    String verificationId = '';

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Android'da ba'zan avtomatik tasdiqlanadi (SMS auto-detect)
      },
      verificationFailed: (FirebaseAuthException e) {
        throw Exception(e.message ?? 'Telefon raqamini tasdiqlashda xatolik');
      },
      codeSent: (String id, int? resendToken) {
        verificationId = id;
      },
      codeAutoRetrievalTimeout: (String id) {
        verificationId = id;
      },
      timeout: const Duration(seconds: 60),
    );

    return verificationId;
  }

  @override
  Future<UserModel> confirmPhoneCode({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final userCredential = await firebaseAuth.signInWithCredential(credential);
    return _mapFirebaseUser(userCredential.user!);
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
    await googleSignIn.signOut();
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) return null;
    return _mapFirebaseUser(user);
  }
}