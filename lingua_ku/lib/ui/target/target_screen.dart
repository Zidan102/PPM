import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/target_harian_repository.dart';
import 'target_view_model.dart';

class TargetScreen extends StatefulWidget {
  const TargetScreen({super.key});

  @override
  State<TargetScreen> createState() => _TargetScreenState();
}

class _TargetScreenState extends State<TargetScreen> {
  late final TargetViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TargetViewModel(context.read<TargetHarianRepository>())..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checklist Target Harian')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          if (_viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_viewModel.error != null) {
            return Center(child: Text(_viewModel.error!));
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Belum Selesai',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${_viewModel.belumSelesai.length} target',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ..._viewModel.belumSelesai.map(
                (t) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: CheckboxListTile(
                    value: t.isSelesai,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Text(
                      t.judul,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(t.bahasa),
                    secondary: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '+${t.poinXp} XP',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFB45309),
                        ),
                      ),
                    ),
                    onChanged: (_) => _viewModel.toggleChecklist(t.id),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Selesai',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    '${_viewModel.sudahSelesai.length} target',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ..._viewModel.sudahSelesai.map(
                (t) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  color: const Color(0xFFF1F5F9),
                  child: CheckboxListTile(
                    value: t.isSelesai,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    title: Text(
                      t.judul,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    subtitle: Text(t.bahasa),
                    secondary: Text(
                      '+${t.poinXp} XP',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    onChanged: (_) => _viewModel.toggleChecklist(t.id),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}