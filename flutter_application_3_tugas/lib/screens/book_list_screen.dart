import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class BookListScreen extends StatelessWidget {
  BookListScreen({super.key});

  // Data dummy buku
  final List<Book> dummyBooks = [
    Book(id: 'b1', title: 'Pemrograman Flutter & Dart', author: 'Ahmad M.', price: 95000),
    Book(id: 'b2', title: 'Belajar State Management Provider', author: 'Budi S.', price: 75000),
    Book(id: 'b3', title: 'Struktur Data & Algoritma', author: 'Dian K.', price: 120000),
    Book(id: 'b4', title: 'Desain UI/UX Aplikasi Mobile', author: 'Eka P.', price: 85000),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaBookstore'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          // Icon Keranjang dengan Badge Jumlah Item
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const CartScreen()),
                      );
                    },
                  ),
                  if (cart.itemCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 18,
                          minHeight: 18,
                        ),
                        child: Text(
                          '${cart.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: dummyBooks.length,
        itemBuilder: (context, index) {
          final book = dummyBooks[index];
          
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${book.author}\nRp ${book.price.toStringAsFixed(0)}'),
              isThreeLine: true,
              trailing: Consumer<CartProvider>(
                builder: (context, cart, child) {
                  final inCart = cart.isInCart(book);
                  return ElevatedButton(
                    onPressed: () {
                      if (inCart) {
                        cart.removeBook(book);
                      } else {
                        cart.addBook(book);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: inCart ? Colors.grey : Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(inCart ? 'Batal' : 'Beli'),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}