import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nexride/auth/presentation/screens/login_screen.dart';
import 'package:nexride/core/theme/app_colors.dart';

import '../../../core/router/app_router.dart';
import '../widgets/slide_to_action.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Slide To\nStart Driving',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nexride bilan har qanday manzilga yetib boring',
                  style: TextStyle(fontSize: 15, color: AppColors.textGrey),
                ),
              ),
              const Spacer(),
              // Mashina tasviri o'rniga hozircha ikonka - keyinroq rasm bilan almashtiramiz
              Container(
                width: 260,
                height: 260,
                decoration: const BoxDecoration(
                  color: AppColors.cardBackground,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/cars/car_onboarding.png',
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.directions_car_filled,
                    size: 140,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const Spacer(),
              SlideToAction(
                text: 'Slide to Start Driving',
                onSlideComplete: () {
                  context.go(AppRoutes.login);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}