import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // Tambahkan variabel state untuk filter di sini (misal: kategori, urutan, dll)
  String _selectedCategory = 'Semua';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Judul Bottom Sheet
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter Pencarian',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 8),

          // Contoh Konten Filter (Kategori)
          const Text(
            'Kategori',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children: ['Semua', 'Terbaru', 'Terpopuler'].map((category) {
              return ChoiceChip(
                label: Text(category),
                selected: _selectedCategory == category,
                onSelected: (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Tombol Aksi (Terapkan & Reset)
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    // Logika reset filter
                    Navigator.pop(context);
                  },
                  child: const Text('Reset'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // Logika menerapkan filter, lalu tutup bottom sheet
                    Navigator.pop(context, _selectedCategory);
                  },
                  child: const Text('Terapkan'),
                ),
              ),
            ],
          ),
          // Beri padding bawah agar aman dari gestur bar HP
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}