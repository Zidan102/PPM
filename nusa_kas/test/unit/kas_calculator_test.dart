import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kas/domain/kas_calculator.dart';
import 'package:nusa_kas/domain/models/transaksi.dart';

void main() {
  late KasCalculator calculator;

  setUp(() {
    calculator = KasCalculator();
  });

  Transaksi buatTransaksi({
    required String id,
    required int nominal,
    required JenisTransaksi jenis,
    String keterangan = 'Kas',
  }) {
    return Transaksi(
      id: id,
      keterangan: keterangan,
      nominal: nominal,
      jenis: jenis,
      tanggal: DateTime(2026, 11, 19),
    );
  }

  test('1. Daftar kosong mengembalikan pemasukan 0, pengeluaran 0, saldo 0', () {
    expect(calculator.totalPemasukan([]), 0);
    expect(calculator.totalPengeluaran([]), 0);
    expect(calculator.hitungSaldo([]), 0);
  });

  test('2. Menghitung total pemasukan dengan benar', () {
    final items = [
      buatTransaksi(id: '1', nominal: 100000, jenis: JenisTransaksi.pemasukan),
      buatTransaksi(id: '2', nominal: 50000, jenis: JenisTransaksi.pemasukan),
      buatTransaksi(id: '3', nominal: 25000, jenis: JenisTransaksi.pengeluaran),
    ];

    expect(calculator.totalPemasukan(items), 150000);
  });

  test('3. Menghitung total pengeluaran dengan benar', () {
    final items = [
      buatTransaksi(id: '1', nominal: 200000, jenis: JenisTransaksi.pemasukan),
      buatTransaksi(id: '2', nominal: 45000, jenis: JenisTransaksi.pengeluaran),
      buatTransaksi(id: '3', nominal: 30000, jenis: JenisTransaksi.pengeluaran),
    ];

    expect(calculator.totalPengeluaran(items), 75000);
  });

  test('4. Menghitung saldo selisih pemasukan dan pengeluaran', () {
    final items = [
      buatTransaksi(id: '1', nominal: 300000, jenis: JenisTransaksi.pemasukan),
      buatTransaksi(id: '2', nominal: 120000, jenis: JenisTransaksi.pengeluaran),
    ];

    expect(calculator.hitungSaldo(items), 180000);
  });

  test('5. Nilai batas: pengeluaran tepat sama dengan saldo diperbolehkan', () {
    final items = [
      buatTransaksi(id: '1', nominal: 150000, jenis: JenisTransaksi.pemasukan),
    ];

    final error = calculator.validasiPengeluaran(
      items,
      JenisTransaksi.pengeluaran,
      150000,
    );

    expect(error, isNull);
  });

  test('6. Menolak nominal nol', () {
    final error = calculator.validasiNominal(0);
    expect(error, isNotNull);
  });

  test('7. Menolak nominal negatif', () {
    final error = calculator.validasiNominal(-10000);
    expect(error, isNotNull);
  });

  test('8. Menolak pengeluaran yang melebihi saldo', () {
    final items = [
      buatTransaksi(id: '1', nominal: 100000, jenis: JenisTransaksi.pemasukan),
    ];

    final error = calculator.validasiPengeluaran(
      items,
      JenisTransaksi.pengeluaran,
      100001,
    );

    expect(error, isNotNull);
  });

  test('9. Pemasukan dengan nominal positif valid meski saldo awal 0', () {
    final error = calculator.validasiPengeluaran(
      [],
      JenisTransaksi.pemasukan,
      50000,
    );

    expect(error, isNull);
  });
}