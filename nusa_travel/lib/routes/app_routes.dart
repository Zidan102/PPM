import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/booking_screen.dart';
import '../screens/not_found_screen.dart';
import '../models/tour_package.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String detail = '/detail';
  static const String booking = '/booking';

  // Static routes map
  static Map<String, WidgetBuilder> get routes => {
        splash: (context) => const SplashScreen(),
        home: (context) => const HomeScreen(),
        booking: (context) => const BookingScreen(),
      };

  // Dynamic route handling (Detail Screen dengan Arguments)
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == detail) {
      final args = settings.arguments;
      if (args is TourPackage) {
        return MaterialPageRoute(
          builder: (context) => DetailScreen(package: args),
        );
      }
    }
    return null;
  }

  // Fallback untuk route tidak dikenal (404 Error)
  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const NotFoundScreen(),
    );
  }
}