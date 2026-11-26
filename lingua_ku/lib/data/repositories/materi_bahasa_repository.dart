import '../../domain/models/materi_bahasa.dart';
import '../services/linguaku_service.dart';

class MateriBahasaRepository {
  final LinguakuService _service;
  List<MateriBahasa>? _cache;

  MateriBahasaRepository(this._service);

  Future<List<MateriBahasa>> getAllMateri() async {
    if (_cache != null) return _cache!;
    final rawList = await _service.fetchMateriJson();
    _cache = rawList.map((e) => MateriBahasa.fromJson(e)).toList();
    return _cache!;
  }

  Future<List<MateriBahasa>> getMateriByBahasa(String bahasa) async {
    final all = await getAllMateri();
    return all.where((m) => m.bahasa == bahasa).toList();
  }
}