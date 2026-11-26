import 'package:flutter/foundation.dart';
import '../../data/repositories/target_harian_repository.dart';
import '../../domain/models/target_harian.dart';

class TargetViewModel extends ChangeNotifier {
  final TargetHarianRepository _repository;

  bool isLoading = false;
  String? error;

  TargetViewModel(this._repository) {
    _repository.addListener(_onRepoChanged);
  }

  List<TargetHarian> get belumSelesai => _repository.belumSelesai;
  List<TargetHarian> get sudahSelesai => _repository.sudahSelesai;

  void _onRepoChanged() {
    notifyListeners();
  }

  Future<void> load() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      await _repository.loadTargets();
    } catch (e) {
      error = 'Gagal memuat target harian: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleChecklist(String id) {
    _repository.toggleTarget(id);
  }

  @override
  void dispose() {
    _repository.removeListener(_onRepoChanged);
    super.dispose();
  }
}