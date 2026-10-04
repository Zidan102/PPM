import 'package:flutter/material.dart';

const String namaSiswa = 'Muhammad Zidan Alfikri';
const String nimSiswa = '20240040257';
const String kelasSiswa = 'TI24G';

const String namaProduk = 'Laptop Gaming High End';
const int hargaProduk = 18500000;
const String kategoriProduk = 'Elektronik & Komputer';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas PPM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const ProfilePage(),
    );
  }
}

// Halaman utama menggunakan Scaffold
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PPM Sesi 2 - $namaSiswa ($nimSiswa)',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Kartu Profil (StatelessWidget)
            ProfileCard(),
            SizedBox(height: 16),

            // Kartu Produk (StatefulWidget)
            ProductCard(),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 1. PROFILE CARD (StatelessWidget)
// ==========================================
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Foto atau Ikon Profil
            const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.deepPurpleAccent,
              child: Icon(Icons.person, size: 40, color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),

            // Nama Mahasiswa
            const Text(
              namaSiswa,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),

            // NIM
            const Text(
              'NIM: $nimSiswa',
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 2),

            // Prodi / Kelas
            const Text(
              'Prodi: $kelasSiswa',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),

            // 5 Ikon Bintang
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) =>
                    const Icon(Icons.star, color: Colors.amber, size: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. PRODUCT CARD (StatefulWidget)
// ==========================================
class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // State variabel
  bool isFavorite = false;
  int likeCount = 12;
  int quantity = 1; // Jumlah minimal 1

  // Format angka ke format mata uang Rupiah
  String formatRupiah(int number) {
    return "Rp ${number.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match match) => '${match[1]}.')}";
  }

  @override
  Widget build(BuildContext context) {
    int totalHarga = hargaProduk * quantity;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk dengan Banner Promo menggunakan Stack & Positioned
            Stack(
              children: [
                // Layer 1: Gambar/Placeholder Produk
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 160,
                    width: double.infinity,
                    color: Colors.deepPurple.shade50,
                    child: const Center(
                      child: Icon(
                        Icons.laptop_mac,
                        size: 80,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ),
                ),

                // Layer 2: Banner Promo Sederhana (Positioned)
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'PROMO 20%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Kategori Produk
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                kategoriProduk,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Nama Produk & Button Favorite
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: const Text(
                    namaProduk,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite;
                      if (isFavorite) {
                        likeCount++;
                      } else {
                        likeCount--;
                      }
                    });
                  },
                ),
              ],
            ),

            Text(
              '$likeCount Suka',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),

            // Harga Satuan
            Text(
              'Harga Satuan: ${formatRupiah(hargaProduk)}',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 12),

            const Divider(),

            // Pengatur Jumlah Produk (Tombol - dan +)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Jumlah:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    // Tombol Kurang (-)
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      color: quantity > 1 ? Colors.teal : Colors.grey,
                      onPressed: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                    ),

                    // Display Angka Jumlah
                    Text(
                      '$quantity',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // Tombol Tambah (+)
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      color: Colors.teal,
                      onPressed: () {
                        setState(() {
                          quantity++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            // Total Harga
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Harga:',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Text(
                  formatRupiah(totalHarga),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Tombol "Tambah ke Keranjang"
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                label: const Text(
                  'Tambah ke Keranjang',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  // Menampilkan SnackBar saat ditekan
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '$quantity $namaProduk berhasil ditambahkan ke keranjang!',
                      ),
                      duration: const Duration(seconds: 2),
                      backgroundColor: Colors.deepPurple,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
