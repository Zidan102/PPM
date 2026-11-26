import 'package:flutter_test/flutter_test.dart';
import 'package:lingua_ku/data/repositories/tips_budaya_repository.dart';
import 'package:lingua_ku/data/services/linguaku_service.dart';
import 'package:lingua_ku/ui/tips_budaya/tips_budaya_view_model.dart';

void main() {
  test('TipsBudayaViewModel memuat data dan memfilter berdasarkan bahasa & kata kunci', () async {
    final service = LinguakuService();
    final repository = TipsBudayaRepository(service);
    final viewModel = TipsBudayaViewModel(repository);

    expect(viewModel.isLoading, false);
    expect(viewModel.hasilTips, isEmpty);

    await viewModel.load();

    expect(viewModel.isLoading, false);
    expect(viewModel.error, isNull);
    expect(viewModel.hasilTips.length, greaterThanOrEqualTo(5));

    // Uji filter bahasa Jepang
    viewModel.pilihFilterBahasa('Jepang');
    expect(viewModel.hasilTips.every((t) => t.bahasa == 'Jepang'), isTrue);

    // Uji pencarian kata kunci
    viewModel.pilihFilterBahasa('Semua');
    viewModel.cariUngkapan('cake');
    expect(viewModel.hasilTips.length, 1);
    expect(viewModel.hasilTips.first.ungkapan, 'Piece of cake');
  });
}