import 'package:flutter/material.dart';
import 'package:nexride/auth/domain/usecases/register_usecase.dart';
import 'package:nexride/auth/domain/usecases/login_usecase.dart';
import 'package:nexride/core/di/injection.dart';

class AuthTestScreen extends StatefulWidget {
  const AuthTestScreen({super.key});

  @override
  State<AuthTestScreen> createState() => _AuthTestScreenState();
}

class _AuthTestScreenState extends State<AuthTestScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String resultText = '';
  bool isLoading = false;

  Future<void> _register() async {
    setState(() {
      isLoading = true;
      resultText = '';
    });

    try {
      final registerUsecase = getIt<RegisterUsecase>();
      final user = await registerUsecase(
        name: 'Test User',
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() {
        resultText = 'Ro\'yxatdan o\'tdi ✅\nID: ${user.id}\nEmail: ${user.email}';
      });
    } catch (e) {
      setState(() {
        resultText = 'Xato ❌: $e';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _login() async {
    setState(() {
      isLoading = true;
      resultText = '';
    });

    try {
      final loginUsecase = getIt<LoginUsecase>();
      final user = await loginUsecase(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() {
        resultText = 'Kirish muvaffaqiyatli ✅\nID: ${user.id}\nEmail: ${user.email}';
      });
    } catch (e) {
      setState(() {
        resultText = 'Xato ❌: $e';
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth Test')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Parol'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            if (isLoading) const CircularProgressIndicator(),
            if (!isLoading)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _register,
                    child: const Text('Ro\'yxatdan o\'tish'),
                  ),
                  ElevatedButton(
                    onPressed: _login,
                    child: const Text('Kirish'),
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Text(resultText),
          ],
        ),
      ),
    );
  }
}