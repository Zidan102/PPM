import 'package:flutter/foundation.dart';
import '../../domain/models/target_harian.dart';
import '../services/linguaku_service.dart';

class TargetHarianRepository extends ChangeNotifier {
  final LinguakuService _service;
  List<TargetHarian> _items = [];
  bool _isInitialized = false;

  TargetHarianRepository(this._service);

  List<TargetHarian> get allTargets => List.unmodifiable(_items);
  List<TargetHarian> get belumSelesai =>
      _items.where((item) => !item.isSelesai).toList();
  List<TargetHarian> get sudahSelesai =>
      _items.where((item) => item.isSelesai).toList();

  int get jumlahBelumSelesai => belumSelesai.length;

  Future<void> loadTargets() async {
    if (_isInitialized) return;
    final rawList = await _service.fetchTargetJson();
    _items = rawList.map((e) => TargetHarian.fromJson(e)).toList();
    _isInitialized = true;
    notifyListeners();
  }

  void toggleTarget(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    if (index != -1) {
      final current = _items[index];
      _items[index] = current.copyWith(isSelesai: !current.isSelesai);
      notifyListeners();
    }
  }
}