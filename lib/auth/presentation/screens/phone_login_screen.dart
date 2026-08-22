import 'package:flutter/material.dart';
import 'package:nexride/auth/domain/usecases/confirm_phone_code_usecase.dart';
import 'package:nexride/auth/domain/usecases/verify_phone_usecase.dart';
import 'package:nexride/auth/presentation/widgets/custom_button.dart';
import 'package:nexride/auth/presentation/widgets/custom_text_field.dart';
import 'package:nexride/core/di/injection.dart';
import 'package:nexride/core/theme/app_colors.dart';
import 'package:nexride/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:nexride/core/router/app_router.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final phoneController = TextEditingController();
  final codeController = TextEditingController();

  bool isLoading = false;
  bool codeSent = false;
  String verificationId = '';

  Future<void> _sendCode() async {
    if (phoneController.text.trim().isEmpty) {
      _showError('Telefon raqamini kiriting');
      return;
    }

    setState(() => isLoading = true);

    try {
      final verifyPhoneUsecase = getIt<VerifyPhoneUsecase>();
      final id = await verifyPhoneUsecase(phoneNumber: phoneController.text.trim());
      setState(() {
        verificationId = id;
        codeSent = true;
      });
    } catch (e) {
      _showError('Kod yuborishda xatolik yuz berdi');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _confirmCode() async {
    if (codeController.text.trim().isEmpty) {
      _showError('SMS kodni kiriting');
      return;
    }

    setState(() => isLoading = true);

    try {
      final confirmUsecase = getIt<ConfirmPhoneCodeUsecase>();
      await confirmUsecase(
        verificationId: verificationId,
        smsCode: codeController.text.trim(),
      );

      if (!mounted) return;
      context.go(AppRoutes.home);
    } catch (e) {
      _showError('Kod noto\'g\'ri, qaytadan urinib ko\'ring');
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade400),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                codeSent ? 'Kodni tasdiqlang' : 'Telefon raqami',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textDark),
              ),
              const SizedBox(height: 8),
              Text(
                codeSent
                    ? 'SMS orqali yuborilgan 6 xonali kodni kiriting'
                    : 'Login qilish uchun telefon raqamingizni kiriting (masalan: +998901234567)',
                style: const TextStyle(fontSize: 14, color: AppColors.textGrey),
              ),
              const SizedBox(height: 28),
              if (!codeSent) ...[
                CustomTextField(
                  controller: phoneController,
                  label: 'Telefon raqami',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                ),
                const SizedBox(height: 24),
                CustomButton(text: 'Kod yuborish', onPressed: _sendCode, isLoading: isLoading),
              ] else ...[
                CustomTextField(
                  controller: codeController,
                  label: 'SMS kod',
                  keyboardType: TextInputType.number,
                  prefixIcon: Icons.sms_outlined,
                ),
                const SizedBox(height: 24),
                CustomButton(text: 'Tasdiqlash', onPressed: _confirmCode, isLoading: isLoading),
              ],
            ],
          ),
        ),
      ),
    );
  }
}