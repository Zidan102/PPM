import 'package:flutter/foundation.dart';
import '../../data/repositories/tips_budaya_repository.dart';
import '../../domain/models/tips_budaya.dart';

class TipsBudayaViewModel extends ChangeNotifier {
  final TipsBudayaRepository _repository;

  bool isLoading = false;
  String? error;
  List<TipsBudaya> _semuaTips = [];
  String kataKunci = '';
  String filterBahasa = 'Semua';

  TipsBudayaViewModel(this._repository);

  List<TipsBudaya> get hasilTips {
    return _semuaTips.where((tip) {
      final cocokBahasa =
          filterBahasa == 'Semua' || tip.bahasa == filterBahasa;
      final cocokKata = kataKunci.isEmpty ||
          tip.ungkapan.toLowerCase().contains(kataKunci.toLowerCase()) ||
          tip.arti.toLowerCase().contains(kataKunci.toLowerCase());
      return cocokBahasa && cocokKata;
    }).toList();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      _semuaTips = await _repository.getAllTips();
    } catch (e) {
      error = 'Gagal memuat info budaya: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void cariUngkapan(String query) {
    kataKunci = query;
    notifyListeners();
  }

  void pilihFilterBahasa(String bahasa) {
    filterBahasa = bahasa;
    notifyListeners();
  }
}