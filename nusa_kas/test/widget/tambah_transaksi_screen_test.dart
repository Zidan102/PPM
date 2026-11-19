import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nusa_kas/domain/models/transaksi.dart';
import 'package:nusa_kas/ui/kas/kas_view_model.dart';
import 'package:nusa_kas/ui/kas/tambah_transaksi_screen.dart';

void main() {
  testWidgets('1. Menampilkan pesan error jika form kosong saat Simpan ditekan',
      (WidgetTester tester) async {
    final vm = KasViewModel();

    await tester.pumpWidget(
      MaterialApp(
        home: TambahTransaksiScreen(viewModel: vm),
      ),
    );

    await tester.tap(find.byKey(const Key('simpan_button')));
    await tester.pump();

    expect(find.text('Keterangan tidak boleh kosong'), findsOneWidget);
    expect(find.text('Nominal tidak boleh kosong'), findsOneWidget);
  });

  testWidgets('2. Menolak nominal nol atau negatif pada form',
      (WidgetTester tester) async {
    final vm = KasViewModel();

    await tester.pumpWidget(
      MaterialApp(
        home: TambahTransaksiScreen(viewModel: vm),
      ),
    );

    await tester.enterText(
      find.byKey(const Key('keterangan_field')),
      'Iuran Wajib',
    );
    await tester.enterText(find.byKey(const Key('nominal_field')), '0');
    await tester.tap(find.byKey(const Key('simpan_button')));
    await tester.pump();

    expect(find.text('Nominal harus lebih dari 0'), findsOneWidget);
    expect(vm.transaksiList, isEmpty);
  });

  testWidgets('3. Menyimpan transaksi pemasukan valid ke ViewModel',
      (WidgetTester tester) async {
    final vm = KasViewModel();

    await tester.pumpWidget(
      MaterialApp(
        home: TambahTransaksiScreen(viewModel: vm),
      ),
    );

    await tester.enterText(
      find.byKey(const Key('keterangan_field')),
      'Kas Mingguan',
    );
    await tester.enterText(find.byKey(const Key('nominal_field')), '50000');
    await tester.tap(find.byKey(const Key('simpan_button')));
    await tester.pumpAndSettle();

    expect(vm.transaksiList.length, 1);
    expect(vm.transaksiList.first.keterangan, 'Kas Mingguan');
    expect(vm.transaksiList.first.nominal, 50000);
    expect(vm.transaksiList.first.jenis, JenisTransaksi.pemasukan);
    expect(vm.saldo, 50000);
  });
}