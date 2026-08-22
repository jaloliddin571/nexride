import 'package:flutter/material.dart';
import 'package:nexride/auth/domain/usecases/register_usecase.dart';
import 'package:nexride/auth/presentation/widgets/custom_button.dart';
import 'package:nexride/auth/presentation/widgets/custom_text_field.dart';
import 'package:nexride/core/di/injection.dart';

import '../../../core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
    State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _register() async {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      _showError('Barcha maydonlarni to\'ldiring');
      return;
    }

    if (passwordController.text.trim().length < 6) {
      _showError('Parol kamida 6 belgidan iborat bo\'lishi kerak');
      return;
    }

    setState(() => isLoading = true);

    try {
      final registerUsecase = getIt<RegisterUsecase>();
      await registerUsecase(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ro\'yxatdan muvaffaqiyatli o\'tdingiz ✅')),
      );
      context.pop();
    } catch (e) {
      _showError(_parseFirebaseError(e.toString()));
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade400),
    );
  }

  String _parseFirebaseError(String error) {
    if (error.contains('email-already-in-use')) {
      return 'Bu email allaqachon ro\'yxatdan o\'tgan';
    }
    if (error.contains('invalid-email')) {
      return 'Email formati noto\'g\'ri';
    }
    if (error.contains('weak-password')) {
      return 'Parol juda oddiy, kuchliroq parol tanlang';
    }
    return 'Xatolik yuz berdi, qaytadan urinib ko\'ring';
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ro\'yxatdan o\'tish',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Nexride oilasiga qo\'shiling',
                style: TextStyle(fontSize: 15, color: AppColors.textGrey),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                controller: nameController,
                label: 'Ism',
                prefixIcon: Icons.person_outline,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: emailController,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: passwordController,
                label: 'Parol',
                obscureText: true,
                prefixIcon: Icons.lock_outline,
              ),
              const SizedBox(height: 28),
              CustomButton(
                text: 'Ro\'yxatdan o\'tish',
                onPressed: _register,
                isLoading: isLoading,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}