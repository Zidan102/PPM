import 'models/transaksi.dart';

class KasCalculator {
  int totalPemasukan(List<Transaksi> items) {
    return items
        .where((item) => item.jenis == JenisTransaksi.pemasukan)
        .fold(0, (sum, item) => sum + item.nominal);
  }

  int totalPengeluaran(List<Transaksi> items) {
    return items
        .where((item) => item.jenis == JenisTransaksi.pengeluaran)
        .fold(0, (sum, item) => sum + item.nominal);
  }

  int hitungSaldo(List<Transaksi> items) {
    return totalPemasukan(items) - totalPengeluaran(items);
  }

  String? validasiNominal(int nominal) {
    if (nominal <= 0) {
      return 'Nominal harus lebih dari 0';
    }
    return null;
  }

  String? validasiPengeluaran(
    List<Transaksi> items,
    JenisTransaksi jenis,
    int nominal,
  ) {
    final nominalError = validasiNominal(nominal);
    if (nominalError != null) {
      return nominalError;
    }

    if (jenis == JenisTransaksi.pengeluaran) {
      final saldoSaatIni = hitungSaldo(items);
      if (nominal > saldoSaatIni) {
        return 'Pengeluaran melebihi saldo tersedia (Rp $saldoSaatIni)';
      }
    }

    return null;
  }
}