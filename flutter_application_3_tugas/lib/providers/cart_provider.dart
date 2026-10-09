import 'package:flutter/foundation.dart';
import '../models/book.dart';

class CartProvider with ChangeNotifier {
  final List<Book> _items = [];

  // Getter untuk mengambil daftar buku di keranjang
  List<Book> get items => _items;

  // Total jumlah buku di keranjang
  int get itemCount => _items.length;

  // Hitung total harga
  double get totalPrice {
    return _items.fold(0.0, (sum, item) => sum + item.price);
  }

  // Cek apakah buku sudah ada di keranjang
  bool isInCart(Book book) {
    return _items.any((item) => item.id == book.id);
  }

  // Tambah buku ke keranjang
  void addBook(Book book) {
    if (!isInCart(book)) {
      _items.add(book);
      notifyListeners(); // Memberitahu UI untuk update tampilan
    }
  }

  // Hapus buku dari keranjang
  void removeBook(Book book) {
    _items.removeWhere((item) => item.id == book.id);
    notifyListeners(); // Memberitahu UI untuk update tampilan
  }

  // Bersihkan keranjang
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}