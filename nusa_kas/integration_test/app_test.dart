import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nusa_kas/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Menambah dua transaksi lalu memeriksa saldo akhir',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NusaKasApp());
    await tester.pumpAndSettle();

    // 1. Tambah transaksi pemasukan Rp 100.000
    await tester.tap(find.byKey(const Key('tambah_transaksi_fab')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('keterangan_field')),
      'Dana Kegiatan',
    );
    await tester.enterText(find.byKey(const Key('nominal_field')), '100000');
    await tester.tap(find.byKey(const Key('simpan_button')));
    await tester.pumpAndSettle();

    expect(find.text('Dana Kegiatan'), findsOneWidget);
    expect(find.text('Rp 100.000'), findsOneWidget);

    // 2. Tambah transaksi pengeluaran Rp 40.000
    await tester.tap(find.byKey(const Key('tambah_transaksi_fab')));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byKey(const Key('keterangan_field')),
      'Beli Spidol',
    );
    await tester.enterText(find.byKey(const Key('nominal_field')), '40000');
    await tester.tap(find.byKey(const Key('jenis_dropdown')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pengeluaran').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('simpan_button')));
    await tester.pumpAndSettle();

    // 3. Periksa saldo akhir (100.000 - 40.000 = 60.000)
    expect(find.text('Beli Spidol'), findsOneWidget);
    expect(find.text('Rp 60.000'), findsOneWidget);
  });
}