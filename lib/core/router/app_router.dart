import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:nexride/auth/presentation/screens/login_screen.dart';
import 'package:nexride/auth/presentation/screens/onboarding_screen.dart';
import 'package:nexride/auth/presentation/screens/phone_login_screen.dart';
import 'package:nexride/auth/presentation/screens/register_screen.dart';
import 'package:nexride/home/presentation/screens/home_screen.dart';

import '../../home/ride/presentation/screens/choose_vehicle_screen.dart';
import '../../home/ride/presentation/screens/trip_booking_screen.dart';
import '../../home/ride/presentation/screens/trip_details_screen.dart';
import '../../home/ride/presentation/screens/trip_tracking_screen.dart';
import '../../home/ride/profile/presentation/screens/profile_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const onboarding = '/';
  static const login = '/login';
  static const register = '/register';
  static const phoneLogin = '/phone-login';
  static const home = '/home';
  static const chooseVehicle = '/choose-vehicle';
  static const tripBooking = '/trip-booking';
  static const tripTracking = '/trip-tracking';
  static const profile = '/profile';
  static const tripDetails = '/trip-details';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  redirect: (context, state) {
    final isLoggedIn = FirebaseAuth.instance.currentUser != null;
    final currentPath = state.matchedLocation;

    // Auth ekranlari ro'yxati (login qilmagan foydalanuvchi kirishi mumkin bo'lgan joylar)
    final authRoutes = [
      AppRoutes.onboarding,
      AppRoutes.login,
      AppRoutes.register,
      AppRoutes.phoneLogin,
    ];

    final isOnAuthRoute = authRoutes.contains(currentPath);

    // Agar login qilgan bo'lsa-yu, hali auth ekranida tursa -> Home'ga o'tkaz
    if (isLoggedIn && isOnAuthRoute) {
      return AppRoutes.home;
    }

    // Agar login qilmagan bo'lsa-yu, auth bo'lmagan ekranga kirmoqchi bo'lsa -> Onboarding'ga qaytar
    if (!isLoggedIn && !isOnAuthRoute) {
      return AppRoutes.onboarding;
    }

    // Aks holda hech narsani o'zgartirma
    return null;
  },
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.phoneLogin,
      builder: (context, state) => const PhoneLoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.chooseVehicle,
      builder: (context, state) => const ChooseVehicleScreen(),
    ),
    GoRoute(
      path: AppRoutes.tripBooking,
      builder: (context, state) => const TripBookingScreen(),
    ),
    GoRoute(
      path: AppRoutes.tripDetails,
      builder: (context, state) => const TripDetailsScreen(),
    ),
    GoRoute(
      path: AppRoutes.tripTracking,
      builder: (context, state) => const TripTrackingScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);