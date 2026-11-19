import '../../domain/models/transaksi.dart';

class TransaksiRepository {
  final List<Transaksi> _items = [];

  List<Transaksi> getAll() => List.unmodifiable(_items);

  void add(Transaksi transaksi) {
    _items.add(transaksi);
  }

  void removeById(String id) {
    _items.removeWhere((item) => item.id == id);
  }

  void clear() {
    _items.clear();
  }
}