import 'package:flutter/material.dart';
import '../../domain/models/transaksi.dart';
import 'kas_view_model.dart';

class TambahTransaksiScreen extends StatefulWidget {
  final KasViewModel viewModel;

  const TambahTransaksiScreen({super.key, required this.viewModel});

  @override
  State<TambahTransaksiScreen> createState() => _TambahTransaksiScreenState();
}

class _TambahTransaksiScreenState extends State<TambahTransaksiScreen> {
  final _formKey = GlobalKey<FormState>();
  final _keteranganController = TextEditingController();
  final _nominalController = TextEditingController();
  JenisTransaksi _selectedJenis = JenisTransaksi.pemasukan;
  String? _errorBanner;

  @override
  void dispose() {
    _keteranganController.dispose();
    _nominalController.dispose();
    super.dispose();
  }

  void _simpan() {
    setState(() {
      _errorBanner = null;
    });

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    final nominal = int.tryParse(_nominalController.text.trim()) ?? 0;
    final error = widget.viewModel.tambahTransaksi(
      keterangan: _keteranganController.text,
      nominal: nominal,
      jenis: _selectedJenis,
    );

    if (error != null) {
      setState(() {
        _errorBanner = error;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      return;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Transaksi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                key: const Key('keterangan_field'),
                controller: _keteranganController,
                decoration: const InputDecoration(
                  labelText: 'Keterangan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Keterangan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                key: const Key('nominal_field'),
                controller: _nominalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nominal',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nominal tidak boleh kosong';
                  }
                  final parsed = int.tryParse(value.trim());
                  if (parsed == null) {
                    return 'Nominal harus berupa angka';
                  }
                  if (parsed <= 0) {
                    return 'Nominal harus lebih dari 0';
                  }
                  if (_selectedJenis == JenisTransaksi.pengeluaran &&
                      parsed > widget.viewModel.saldo) {
                    return 'Pengeluaran melebihi saldo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<JenisTransaksi>(
                key: const Key('jenis_dropdown'),
                value: _selectedJenis,
                decoration: const InputDecoration(
                  labelText: 'Jenis Transaksi',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(
                    value: JenisTransaksi.pemasukan,
                    child: Text('Pemasukan'),
                  ),
                  DropdownMenuItem(
                    value: JenisTransaksi.pengeluaran,
                    child: Text('Pengeluaran'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedJenis = value;
                    });
                  }
                },
              ),
              if (_errorBanner != null) ...[
                const SizedBox(height: 12),
                Text(
                  _errorBanner!,
                  key: const Key('error_text'),
                  style: const TextStyle(color: Colors.red),
                ),
              ],
              const SizedBox(height: 24),
              ElevatedButton(
                key: const Key('simpan_button'),
                onPressed: _simpan,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}