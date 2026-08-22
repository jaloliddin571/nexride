import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nexride/auth/presentation/providers/auth_controller.dart';
import 'package:nexride/auth/presentation/providers/auth_state.dart';
import 'package:nexride/auth/presentation/widgets/custom_button.dart';
import 'package:nexride/auth/presentation/widgets/custom_text_field.dart';
import 'package:nexride/core/router/app_router.dart';
import 'package:nexride/core/theme/app_colors.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _login() {
    if (emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      _showError('Email va parolni kiriting');
      return;
    }
    ref.read(authControllerProvider.notifier).login(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  void _loginWithGoogle() {
    ref.read(authControllerProvider.notifier).loginWithGoogle();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red.shade400),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Auth holatini "tinglaymiz" - o'zgarganda avtomatik reaksiya beramiz
    ref.listen(authControllerProvider, (previous, next) {
      next.whenOrNull(
        success: (user) => context.go(AppRoutes.home),
        error: (message) => _showError(message),
      );
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.maybeWhen(loading: () => true, orElse: () => false);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.directions_car_filled, color: Colors.white, size: 32),
              ),
              const SizedBox(height: 24),
              const Text(
                'Xush kelibsiz',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: AppColors.textDark),
              ),
              const SizedBox(height: 8),
              const Text(
                'Nexride bilan yo\'lga chiqing',
                style: TextStyle(fontSize: 15, color: AppColors.textGrey),
              ),
              const SizedBox(height: 36),
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
              CustomButton(text: 'Kirish', onPressed: _login, isLoading: isLoading),
              const SizedBox(height: 14),
              CustomButton(
                text: 'Google orqali kirish',
                isOutlined: true,
                onPressed: _loginWithGoogle,
              ),
              const SizedBox(height: 14),
              CustomButton(
                text: 'Telefon raqami orqali kirish',
                isOutlined: true,
                onPressed: () => context.push(AppRoutes.phoneLogin),
              ),
              const SizedBox(height: 28),
              Center(
                child: TextButton(
                  onPressed: () => context.push(AppRoutes.register),
                  child: const Text.rich(
                    TextSpan(
                      text: 'Hisobingiz yo\'qmi? ',
                      style: TextStyle(color: AppColors.textGrey),
                      children: [
                        TextSpan(
                          text: 'Ro\'yxatdan o\'ting',
                          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}