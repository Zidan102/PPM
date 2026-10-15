import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'cart_screen.dart';

class BookListScreen extends StatelessWidget {
  BookListScreen({super.key});

  // Minimal 4 buku Tere Liye
  final List<Book> dummyBooks = [
    Book(
      id: 'b1',
      title: 'Bulan',
      author: 'Tere Liye',
      price: 98100,
      imageUrl: 'https://covers.openlibrary.org/b/id/12711082-L.jpg',
    ),
    Book(
      id: 'b2',
      title: 'Matahari',
      author: 'Tere Liye',
      price: 75000,
      imageUrl: 'https://covers.openlibrary.org/b/id/12711084-L.jpg',
    ),
    Book(
      id: 'b3',
      title: 'Bumi',
      author: 'Tere Liye',
      price: 120000,
      imageUrl: 'https://covers.openlibrary.org/b/id/12711081-L.jpg',
    ),
    Book(
      id: 'b4',
      title: 'Bintang',
      author: 'Tere Liye',
      price: 85000,
      imageUrl: 'https://covers.openlibrary.org/b/id/12711085-L.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaBookstore'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        actions: [
          // Tombol untuk Light/Dark Mode (menggunakan context.read untuk aksi trigger)
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: () {
                  context.read<ThemeProvider>().toggleTheme();
                },
              );
            },
          ),
          // AppBar memiliki ikon keranjang dengan badge jumlah item
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
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ),
                      );
                    },
                  ),
                  // Badge jumlah item otomatis berubah ketika buku ditambahkan
                  if (cart.totalItems > 0)
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
                          '${cart.totalItems}',
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
      // Menggunakan ListView
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: dummyBooks.length,
        itemBuilder: (context, index) {
          final book = dummyBooks[index];

          // Menggunakan Card
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book.imageUrl,
                  width: 50,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.book,
                      size: 50,
                      color: Colors.blueAccent,
                    );
                  },
                ),
              ),
              title: Text(
                book.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${book.author}\nRp ${book.price.toStringAsFixed(0)}',
              ),
              isThreeLine: true,
              // Tombol Tambah ke Keranjang
              trailing: Consumer<CartProvider>(
                builder: (context, cart, child) {
                  final isInCart = cart.items.containsKey(book.id);
                  return ElevatedButton(
                    onPressed: () {
                      // Menggunakan context.read() untuk melakukan perubahan data
                      context.read<CartProvider>().addItem(book);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isInCart ? Colors.orange : Colors.blueAccent,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      isInCart
                          ? 'Tambah (${cart.items[book.id]!.quantity})'
                          : 'Tambah ke Keranjang',
                    ),
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