import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  // Map untuk menyimpan daftar buku di keranjang (Key: ID Buku, Value: CartItem)
  final Map<String, CartItem> _items = {};

  // Getter untuk mengambil daftar item di keranjang
  Map<String, CartItem> get items => {..._items};

  // 1. totalItems: Menghitung jumlah seluruh buku (termasuk kuantitasnya)
  int get totalItems {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.quantity;
    });
    return total;
  }

  // 2. totalPrice: Menghitung total harga seluruh buku di keranjang
  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.book.price * cartItem.quantity;
    });
    return total;
  }

  // 3. addItem(): Menambahkan buku atau menambah jumlah jika buku sudah ada
  void addItem(Book book) {
    if (_items.containsKey(book.id)) {
      // Jika buku sudah ada, tambah jumlahnya (quantity)
      _items.update(
        book.id,
        (existingItem) => CartItem(
          book: existingItem.book,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      // Jika buku belum ada, masukkan ke keranjang dengan quantity = 1
      _items.putIfAbsent(
        book.id,
        () => CartItem(book: book, quantity: 1),
      );
    }
    notifyListeners(); // Memanggil notifyListeners() setiap ada perubahan
  }

  // 4. removeItem(): Mengurangi jumlah atau menghapus buku dari keranjang
  void removeItem(String bookId) {
    if (!_items.containsKey(bookId)) {
      return;
    }

    if (_items[bookId]!.quantity > 1) {
      // Jika jumlahnya lebih dari 1, kurangi kuantitasnya
      _items.update(
        bookId,
        (existingItem) => CartItem(
          book: existingItem.book,
          quantity: existingItem.quantity - 1,
        ),
      );
    } else {
      // Jika jumlahnya sisa 1, hapus buku dari keranjang
      _items.remove(bookId);
    }
    notifyListeners(); // Memanggil notifyListeners() setiap ada perubahan
  }

  // Fungsi tambahan untuk menghapus satu baris item secara penuh (opsional)
  void removeSingleBookCompletely(String bookId) {
    _items.remove(bookId);
    notifyListeners();
  }

  // 5. clearCart(): Mengosongkan keranjang
  void clearCart() {
    _items.clear();
    notifyListeners(); // Memanggil notifyListeners() setiap ada perubahan
  }
}