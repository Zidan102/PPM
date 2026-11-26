class MateriBahasa {
  final String id;
  final String judul;
  final String bahasa; // 'Inggris', 'Jepang', 'Korea'
  final String level;
  final String deskripsi;

  const MateriBahasa({
    required this.id,
    required this.judul,
    required this.bahasa,
    required this.level,
    required this.deskripsi,
  });

  factory MateriBahasa.fromJson(Map<String, dynamic> json) {
    return MateriBahasa(
      id: json['id'] as String,
      judul: json['judul'] as String,
      bahasa: json['bahasa'] as String,
      level: json['level'] as String,
      deskripsi: json['deskripsi'] as String,
    );
  }
}