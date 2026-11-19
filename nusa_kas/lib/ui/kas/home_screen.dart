import 'package:flutter/material.dart';
import '../../domain/models/transaksi.dart';
import 'kas_view_model.dart';
import 'tambah_transaksi_screen.dart';

class HomeScreen extends StatelessWidget {
  final KasViewModel viewModel;

  const HomeScreen({super.key, required this.viewModel});

  String _formatRupiah(int amount) {
    final isNegative = amount < 0;
    final digits = amount.abs().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(digits[i]);
    }
    return '${isNegative ? '-' : ''}Rp ${buffer.toString()}';
  }

  String _formatTanggal(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
        final items = viewModel.transaksiList;

        return Scaffold(
          appBar: AppBar(
            title: const Text('NusaKas'),
          ),
          body: Column(
            children: [
              Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Saldo Kas Himpunan',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatRupiah(viewModel.saldo),
                        key: const Key('saldo_text'),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Total Pemasukan'),
                              Text(
                                _formatRupiah(viewModel.totalPemasukan),
                                key: const Key('total_pemasukan_text'),
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Total Pengeluaran'),
                              Text(
                                _formatRupiah(viewModel.totalPengeluaran),
                                key: const Key('total_pengeluaran_text'),
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? const Center(
                        child: Text('Belum ada transaksi kas.'),
                      )
                    : ListView.builder(
                        key: const Key('transaksi_list_view'),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          final isPemasukan =
                              item.jenis == JenisTransaksi.pemasukan;

                          return Dismissible(
                            key: Key('dismissible_${item.id}'),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (_) {
                              viewModel.hapusTransaksi(item.id);
                            },
                            child: ListTile(
                              key: Key('transaksi_tile_${item.id}'),
                              title: Text(item.keterangan),
                              subtitle: Text(_formatTanggal(item.tanggal)),
                              trailing: Text(
                                '${isPemasukan ? '+' : '-'} ${_formatRupiah(item.nominal)}',
                                style: TextStyle(
                                  color: isPemasukan
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            key: const Key('tambah_transaksi_fab'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TambahTransaksiScreen(viewModel: viewModel),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}