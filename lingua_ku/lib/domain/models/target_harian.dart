class TargetHarian {
  final String id;
  final String judul;
  final String bahasa;
  final int poinXp;
  final bool isSelesai;

  const TargetHarian({
    required this.id,
    required this.judul,
    required this.bahasa,
    required this.poinXp,
    this.isSelesai = false,
  });

  factory TargetHarian.fromJson(Map<String, dynamic> json) {
    return TargetHarian(
      id: json['id'] as String,
      judul: json['judul'] as String,
      bahasa: json['bahasa'] as String,
      poinXp: json['poinXp'] as int,
      isSelesai: json['isSelesai'] as bool? ?? false,
    );
  }

  TargetHarian copyWith({
    String? id,
    String? judul,
    String? bahasa,
    int? poinXp,
    bool? isSelesai,
  }) {
    return TargetHarian(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      bahasa: bahasa ?? this.bahasa,
      poinXp: poinXp ?? this.poinXp,
      isSelesai: isSelesai ?? this.isSelesai,
    );
  }
}