import 'package:flutter/foundation.dart';
import '../../data/repositories/transaksi_repository.dart';
import '../../domain/kas_calculator.dart';
import '../../domain/models/transaksi.dart';

class KasViewModel extends ChangeNotifier {
  final TransaksiRepository _repository;
  final KasCalculator _calculator;

  KasViewModel({
    TransaksiRepository? repository,
    KasCalculator? calculator,
  })  : _repository = repository ?? TransaksiRepository(),
        _calculator = calculator ?? KasCalculator();

  List<Transaksi> get transaksiList => _repository.getAll();

  int get totalPemasukan => _calculator.totalPemasukan(transaksiList);

  int get totalPengeluaran => _calculator.totalPengeluaran(transaksiList);

  int get saldo => _calculator.hitungSaldo(transaksiList);

  String? tambahTransaksi({
    required String keterangan,
    required int nominal,
    required JenisTransaksi jenis,
    DateTime? tanggal,
  }) {
    final trimmedKeterangan = keterangan.trim();
    if (trimmedKeterangan.isEmpty) {
      return 'Keterangan wajib diisi';
    }

    final error = _calculator.validasiPengeluaran(
      transaksiList,
      jenis,
      nominal,
    );
    if (error != null) {
      return error;
    }

    final item = Transaksi(
      id: '${DateTime.now().microsecondsSinceEpoch}_${transaksiList.length}',
      keterangan: trimmedKeterangan,
      nominal: nominal,
      jenis: jenis,
      tanggal: tanggal ?? DateTime.now(),
    );

    _repository.add(item);
    notifyListeners();
    return null;
  }

  void hapusTransaksi(String id) {
    _repository.removeById(id);
    notifyListeners();
  }
}