import 'package:flutter/material.dart';
import 'package:nexride/core/theme/app_colors.dart';
import 'package:nexride/home/presentation/widgets/custom_bottom_nav.dart';

import '../../ride/presentation/screens/choose_vehicle_screen.dart';
import '../../ride/profile/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:nexride/core/router/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              // Header: profil va bildirishnoma
              Row(
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: AppColors.cardBackground,
                    child: Icon(Icons.person, color: AppColors.primary),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jon Doe',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textDark),
                        ),
                        Text(
                          'Riga, Latvia',
                          style: TextStyle(fontSize: 13, color: AppColors.textGrey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      color: AppColors.cardBackground,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.notifications_none, color: AppColors.textDark),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const Text(
                'Introducing Nexride –\nThe Future of AI-Driven\nMobility.',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 24),
              // "Car on the way" karta
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      child: const Icon(Icons.location_on, color: Colors.pink),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Car on the way', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
                          Text('15 Hardson Street', style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _quickAction(Icons.home_outlined, 'Add Home'),
                  const SizedBox(width: 10),
                  _quickAction(Icons.business_center_outlined, 'Company'),
                  const SizedBox(width: 10),
                  _quickAction(Icons.add, 'Others'),
                ],
              ),
              const SizedBox(height: 24),
              // Katta banner karta — bosilganda mashina tanlash ekraniga o'tadi
              GestureDetector(
                onTap: () {
                  context.push(AppRoutes.chooseVehicle);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.directions_car_filled, size: 80, color: Colors.white),
                      const SizedBox(height: 16),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                          children: [
                            TextSpan(text: 'Beyond the Wheel '),
                            TextSpan(text: 'Travel', style: TextStyle(fontWeight: FontWeight.normal)),
                          ],
                        ),
                      ),
                      const Text('The Smart Way', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100), // Bottom nav uchun joy
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: CustomBottomNav(
          currentIndex: _navIndex,
          onTap: (index) {
            setState(() => _navIndex = index);
            if (index == 2) {
              context.push(AppRoutes.profile);
            }
          },
        ),
      ),
    );
  }

  Widget _quickAction(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: AppColors.textDark),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textDark)),
          ],
        ),
      ),
    );
  }
}