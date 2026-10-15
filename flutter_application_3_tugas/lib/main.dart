import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/book_list_screen.dart';

void main() {
  runApp(
    // 1. Menggunakan MultiProvider pada root aplikasi
    MultiProvider(
      providers: [
        // Mendaftarkan CartProvider
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        // Mendaftarkan ThemeProvider
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: const NusaBookstoreApp(),
    ),
  );
}

class NusaBookstoreApp extends StatelessWidget {
  const NusaBookstoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 2. Mendengarkan perubahan tema dari ThemeProvider
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'NusaBookstore',
          // Menerapkan themeData dinamis (Light Mode / Dark Mode)
          theme: themeProvider.themeData,
          home: BookListScreen(),
        );
      },
    );
  }
}