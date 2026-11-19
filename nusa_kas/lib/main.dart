import 'package:flutter/material.dart';
import 'ui/kas/home_screen.dart';
import 'ui/kas/kas_view_model.dart';

void main() {
  runApp(const NusaKasApp());
}

class NusaKasApp extends StatelessWidget {
  final KasViewModel? viewModel;

  const NusaKasApp({super.key, this.viewModel});

  @override
  Widget build(BuildContext context) {
    final vm = viewModel ?? KasViewModel();
    return MaterialApp(
      title: 'NusaKas',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: HomeScreen(viewModel: vm),
    );
  }
}