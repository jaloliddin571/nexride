import 'package:flutter/material.dart';
import 'package:nexride/core/theme/app_colors.dart';
import 'package:nexride/auth/presentation/widgets/custom_button.dart';
import 'package:nexride/home/ride/presentation/screens/trip_booking_screen.dart';

import '../../domain/entities/vehicle.dart';
import '../widgets/vehicle_card.dart';
import 'package:go_router/go_router.dart';
import 'package:nexride/core/router/app_router.dart';

class ChooseVehicleScreen extends StatefulWidget {
  const ChooseVehicleScreen({super.key});

  @override
  State<ChooseVehicleScreen> createState() => _ChooseVehicleScreenState();
}

class _ChooseVehicleScreenState extends State<ChooseVehicleScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleIconButton(Icons.arrow_back, () => context.pop()),
                  _circleIconButton(Icons.search, () {}),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Choose Your Nexride',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
              ),
              const SizedBox(height: 4),
              const Text(
                'Preferred Vehicle To Start Your Journey.',
                style: TextStyle(fontSize: 14, color: AppColors.textGrey),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: demoVehicles.length,
                  itemBuilder: (context, index) {
                    return VehicleCard(
                      vehicle: demoVehicles[index],
                      isSelected: selectedIndex == index,
                      onTap: () => setState(() => selectedIndex = index),
                    );
                  },
                ),
              ),
          CustomButton(
            text: 'Davom etish',
            onPressed: () {
              context.push(AppRoutes.tripBooking);
            },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _circleIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6),
        ]),
        child: Icon(icon, color: AppColors.textDark),
      ),
    );
  }
}