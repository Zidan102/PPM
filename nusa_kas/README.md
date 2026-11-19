# NusaKas

Aplikasi pencatatan pemasukan dan pengeluaran kas himpunan berbasis Flutter, dilengkapi dengan pemisahan layer (`domain`, `data`, `ui`), validasi form, serta pengujian otomatis (*unit test*, *widget test*, dan *integration test*).

---

## Screenshot Halaman Aplikasi

### 1. Home Screen (Kondisi Awal / Kosong)
Menampilkan ringkasan **Saldo Kas Himpunan (`Rp 0`)**, **Total Pemasukan (`Rp 0`)**, **Total Pengeluaran (`Rp 0`)**, serta pesan *"Belum ada transaksi kas."* saat daftar transaksi masih kosong[cite: 1, 2].

![Home Screen Kosong](screenshots/Screenshot%202026-11-19%20212921.png)

### 2. Tambah Transaksi Screen (Validasi Input)
Halaman form input **Keterangan**, **Nominal**, dan **Jenis Transaksi** dengan validasi `GlobalKey<FormState>` yang menolak nominal nol/negatif maupun pengeluaran yang melebihi saldo tersedia[cite: 1, 3].

![Validasi Form Transaksi](screenshots/Screenshot%202026-11-19%20213006.png)

### 3. Tambah Transaksi Screen (Input Pengeluaran)
Pengisian transaksi pengeluaran baru (`Hutang Daffa` sebesar `Rp 100.000`) setelah saldo mencukupi[cite: 4].

![Tambah Transaksi Pengeluaran](screenshots/Screenshot%202026-11-19%20213240.png)

### 4. Home Screen (Daftar Transaksi & Perhitungan Saldo)
Menampilkan daftar riwayat transaksi (`Cuan Bitcoin + Rp 1.000.000`, `Utang Daffa - Rp 100.000`, `Hutang Daffa - Rp 100.000`) beserta kalkulasi otomatis **Saldo Kas Himpunan (`Rp 800.000`)**, **Total Pemasukan (`Rp 1.000.000`)**, dan **Total Pengeluaran (`Rp 200.000`)**[cite: 1, 5].

![Home Screen Dengan Transaksi](screenshots/Screenshot%202026-11-19%20213245.png)

---
