import '../../domain/models/tips_budaya.dart';
import '../services/linguaku_service.dart';

class TipsBudayaRepository {
  final LinguakuService _service;
  List<TipsBudaya>? _cache;

  TipsBudayaRepository(this._service);

  Future<List<TipsBudaya>> getAllTips() async {
    if (_cache != null) return _cache!;
    final rawList = await _service.fetchTipsBudayaJson();
    _cache = rawList.map((e) => TipsBudaya.fromJson(e)).toList();
    return _cache!;
  }
}