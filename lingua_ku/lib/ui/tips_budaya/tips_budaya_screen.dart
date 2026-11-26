import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/repositories/tips_budaya_repository.dart';
import 'tips_budaya_view_model.dart';

class TipsBudayaScreen extends StatefulWidget {
  const TipsBudayaScreen({super.key});

  @override
  State<TipsBudayaScreen> createState() => _TipsBudayaScreenState();
}

class _TipsBudayaScreenState extends State<TipsBudayaScreen> {
  late final TipsBudayaViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = TipsBudayaViewModel(context.read<TipsBudayaRepository>())
      ..load();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final daftarFilter = ['Semua', 'Inggris', 'Jepang', 'Korea'];
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Pojok Budaya & Idiom')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari idiom atau arti ungkapan...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                  ),
                  onChanged: _viewModel.cariUngkapan,
                ),
              ),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: daftarFilter.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final bahasa = daftarFilter[index];
                    return ChoiceChip(
                      label: Text(bahasa),
                      selected: _viewModel.filterBahasa == bahasa,
                      onSelected: (_) => _viewModel.pilihFilterBahasa(bahasa),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _viewModel.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _viewModel.error != null
                        ? Center(child: Text(_viewModel.error!))
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _viewModel.hasilTips.length,
                            itemBuilder: (context, index) {
                              final tip = _viewModel.hasilTips[index];
                              return Card(
                                margin: const EdgeInsets.only(bottom: 12),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              tip.ungkapan,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                              color: colorScheme.primary
                                                  .withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              tip.bahasa,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: colorScheme.primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        tip.arti,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF334155),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF8FAFC),
                                          borderRadius: BorderRadius.circular(12),
                                          border: const Border(
                                            left: BorderSide(
                                              color: Color(0xFF4F46E5),
                                              width: 3,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          tip.catatanBudaya,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF475569),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          );
        },
      ),
    );
  }
}