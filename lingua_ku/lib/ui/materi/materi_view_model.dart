import 'package:flutter/foundation.dart';
import '../../data/repositories/materi_bahasa_repository.dart';
import '../../domain/models/materi_bahasa.dart';

class MateriViewModel extends ChangeNotifier {
  final MateriBahasaRepository _repository;

  bool isLoading = false;
  String? error;
  String segmenBahasa = 'Inggris';
  List<MateriBahasa> daftarMateri = [];

  MateriViewModel(this._repository);

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      daftarMateri = await _repository.getMateriByBahasa(segmenBahasa);
    } catch (e) {
      error = 'Gagal memuat materi: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pilihSegmen(String bahasa) async {
    segmenBahasa = bahasa;
    await load();
  }
}