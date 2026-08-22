import 'package:flutter/material.dart';
import 'package:nexride/core/theme/app_colors.dart';
import 'package:nexride/home/ride/presentation/screens/trip_tracking_screen.dart';

import '../../../../auth/presentation/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:nexride/core/router/app_router.dart';

class TripBookingScreen extends StatefulWidget {
  const TripBookingScreen({super.key});

  @override
  State<TripBookingScreen> createState() => _TripBookingScreenState();
}

class _TripBookingScreenState extends State<TripBookingScreen> {
  int selectedTimeIndex = 0;
  final times = ['16:43', '16:55', '17:00', '17:15', '17:30'];

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
                children: [
                  _circleIconButton(Icons.arrow_back, () => context.pop()),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, size: 18, color: AppColors.textGrey),
                          SizedBox(width: 8),
                          Text('Downtown Miami...', style: TextStyle(color: AppColors.textGrey)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Trip',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 16, color: AppColors.textGrey),
                      const SizedBox(width: 4),
                      Text('3 Person Max', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: times.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final isSelected = selectedTimeIndex == index;
                    return GestureDetector(
                      onTap: () => setState(() => selectedTimeIndex = index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primary : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Text(
                          times[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textDark,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Pickup & Dropoff Details Map',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 13),
                      ),
                      const SizedBox(height: 12),
                      // Xarita o'rniga vaqtinchalik placeholder
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(Icons.map_outlined, size: 60, color: AppColors.primary),
                        ),
                      ),
                      const SizedBox(height: 14),
                      _locationTile(Icons.radio_button_checked, Colors.blue, 'Downtown Miami', 'Car Waits 5 Min • 2 Min Walk'),
                      const SizedBox(height: 10),
                      _locationTile(Icons.location_on, Colors.pink, 'Little Havana - 8th Street', 'Drop in 2 Min'),
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          Icon(Icons.add, size: 18, color: AppColors.primary),
                          SizedBox(width: 6),
                          Text('Add A Stop Or Roundtrip', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                        child: const Icon(Icons.payment, size: 16, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      const Text('Payoneer', style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.textDark)),
                    ],
                  ),
                  const Text('US\$9.92', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 16)),
                ],
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'REQUEST CAR',
                onPressed: () {
                  context.push(AppRoutes.tripTracking);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _locationTile(IconData icon, Color color, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.textDark)),
              Text(subtitle, style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
            ],
          ),
        ],
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