class TipsBudaya {
  final String id;
  final String bahasa;
  final String ungkapan;
  final String arti;
  final String catatanBudaya;

  const TipsBudaya({
    required this.id,
    required this.bahasa,
    required this.ungkapan,
    required this.arti,
    required this.catatanBudaya,
  });

  factory TipsBudaya.fromJson(Map<String, dynamic> json) {
    return TipsBudaya(
      id: json['id'] as String,
      bahasa: json['bahasa'] as String,
      ungkapan: json['ungkapan'] as String,
      arti: json['arti'] as String,
      catatanBudaya: json['catatanBudaya'] as String,
    );
  }
}