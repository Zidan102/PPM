class TourPackage {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  TourPackage({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

// Dummy Data untuk 4 Paket Wisata
final List<TourPackage> dummyTourPackages = [
  TourPackage(
    id: 'p1',
    title: 'Keindahan Pantai Pelabuhanratu',
    description:
        'Nikmati pemandangan laut selatan Sukabumi dengan ombak yang menakjubkan dan spot matahari terbenam yang memukau.',
    price: 350000,
    imageUrl: 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=600',
  ),
  TourPackage(
    id: 'p2',
    title: 'Eksplorasi Geopark Ciletuh',
    description:
        'Jelajahi warisan dunia UNESCO dengan air terjun spektakuler, lanskap lanskap alam purba, dan pantai eksotis.',
    price: 750000,
    imageUrl: 'https://images.unsplash.com/photo-1511497584788-8767611136f6?w=600',
  ),
  TourPackage(
    id: 'p3',
    title: 'Petualangan Situ Gunung Suspension Bridge',
    description:
        'Melintasi jembatan gantung terpanjang di Asia Tenggara dan menikmati keasrian air terjun Sawer.',
    price: 450000,
    imageUrl: 'https://images.unsplash.com/photo-1448375240586-882707db888b?w=600',
  ),
  TourPackage(
    id: 'p4',
    title: 'Pesona Kawah Ratu Mt. Salak',
    description:
        'Trekking hiking alami menuju kawah aktif Gunung Salak dengan pemandangan hidrothermal yang memukau.',
    price: 300000,
    imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=600',
  ),
];