enum JenisTransaksi {
  pemasukan,
  pengeluaran,
}

class Transaksi {
  final String id;
  final String keterangan;
  final int nominal;
  final JenisTransaksi jenis;
  final DateTime tanggal;

  const Transaksi({
    required this.id,
    required this.keterangan,
    required this.nominal,
    required this.jenis,
    required this.tanggal,
  });

  Transaksi copyWith({
    String? id,
    String? keterangan,
    int? nominal,
    JenisTransaksi? jenis,
    DateTime? tanggal,
  }) {
    return Transaksi(
      id: id ?? this.id,
      keterangan: keterangan ?? this.keterangan,
      nominal: nominal ?? this.nominal,
      jenis: jenis ?? this.jenis,
      tanggal: tanggal ?? this.tanggal,
    );
  }
}