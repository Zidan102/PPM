import '../models/event_item.dart';

class SampleData {
  static final List<EventItem> events = [
    EventItem(
      id: '1',
      title: 'AI Revolution in Healthcare',
      category: 'AI',
      date: '15 Nov 2026',
      location: 'Auditorium Utama Lt. 3',
      description: 'Mempelajari penerapan kecerdasan buatan dalam dunia medis modern dan masa depan.',
      imageUrl: 'https://picsum.photos/seed/ai/400/200',
    ),
    EventItem(
      id: '2',
      title: 'Cross-Platform App with Flutter',
      category: 'Mobile',
      date: '18 Nov 2026',
      location: 'Lab Komputer Gedung B',
      description: 'Workshop intensif membuat aplikasi multi-platform berperforma tinggi menggunakan Flutter.',
      imageUrl: 'https://picsum.photos/seed/mobile/400/200',
    ),
    EventItem(
      id: '3',
      title: 'Smart Cities & IoT Integration',
      category: 'IoT',
      date: '22 Nov 2026',
      location: 'Ruang Seminar Lt. 2',
      description: 'Diskusi interaktif mengenai arsitektur perangkat keras dan sensor pintar untuk perkotaan.',
      imageUrl: 'https://picsum.photos/seed/iot/400/200',
    ),
    EventItem(
      id: '4',
      title: 'Cybersecurity Defense Workshop',
      category: 'Cybersecurity',
      date: '25 Nov 2026',
      location: 'Auditorium Utama Lt. 3',
      description: 'Strategi pertahanan siber terkini dan simulasi penetration testing dasar.',
      imageUrl: 'https://picsum.photos/seed/cyber/400/200',
    ),
  ];
}