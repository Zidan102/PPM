import 'package:flutter/foundation.dart';
import '../../data/repositories/materi_bahasa_repository.dart';
import '../../data/repositories/target_harian_repository.dart';
import '../../domain/models/materi_bahasa.dart';
import '../../domain/models/target_harian.dart';

class HomeViewModel extends ChangeNotifier {
  final MateriBahasaRepository _materiRepo;
  final TargetHarianRepository _targetRepo;

  bool isLoading = false;
  String? error;
  String bahasaPilihan = 'Inggris';
  List<MateriBahasa> materiRekomendasi = [];

  HomeViewModel(this._materiRepo, this._targetRepo) {
    // Mendengarkan perubahan dari TargetHarianRepository agar Beranda ikut ter-update
    _targetRepo.addListener(_onTargetChanged);
  }

  List<TargetHarian> get targetBelumSelesai => _targetRepo.belumSelesai;

  void _onTargetChanged() {
    notifyListeners();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _targetRepo.loadTargets();
      materiRekomendasi = await _materiRepo.getMateriByBahasa(bahasaPilihan);
    } catch (e) {
      error = 'Gagal memuat ringkasan belajar: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> gantiBahasa(String bahasaBaru) async {
    bahasaPilihan = bahasaBaru;
    await load();
  }

  void selesaikanTarget(String id) {
    _targetRepo.toggleTarget(id);
  }

  @override
  void dispose() {
    _targetRepo.removeListener(_onTargetChanged);
    super.dispose();
  }
}