class LinguakuService {
  Future<List<dynamic>> fetchMateriJson() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {
        'id': 'm1',
        'judul': 'Present Perfect vs Past Simple',
        'bahasa': 'Inggris',
        'level': 'Menengah',
        'deskripsi':
            'Memahami perbedaan waktu kejadian yang masih berdampak hingga kini.',
      },
      {
        'id': 'm2',
        'judul': 'Phrasal Verbs Sehari-hari',
        'bahasa': 'Inggris',
        'level': 'Pemula',
        'deskripsi':
            'Kumpulan frasa kerja populer seperti give up, look after, dan run out.',
      },
      {
        'id': 'm3',
        'judul': 'Mengenal Huruf Hiragana Dasar',
        'bahasa': 'Jepang',
        'level': 'Pemula',
        'deskripsi':
            'Membaca dan menulis 46 karakter dasar Hiragana beserta pelafalannya.',
      },
      {
        'id': 'm4',
        'judul': 'Partikel Wa (は) dan Ga (が)',
        'bahasa': 'Jepang',
        'level': 'Menengah',
        'deskripsi':
            'Cara membedakan penanda topik kalimat dan subjek utama dalam bahasa Jepang.',
      },
      {
        'id': 'm5',
        'judul': 'Membaca Hangeul & Batchim',
        'bahasa': 'Korea',
        'level': 'Pemula',
        'deskripsi':
            'Struktur suku kata Korea dan aturan konsonan akhir (Batchim).',
      },
      {
        'id': 'm6',
        'judul': 'Tingkatan Tutur Banmal vs Jondaetmal',
        'bahasa': 'Korea',
        'level': 'Menengah',
        'deskripsi':
            'Penggunaan bahasa formal dan kasual sesuai usia dan keakraban lawan bicara.',
      },
    ];
  }

  Future<List<dynamic>> fetchTargetJson() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {
        'id': 't1',
        'judul': 'Hafalkan 10 kosakata kerja Bahasa Inggris',
        'bahasa': 'Inggris',
        'poinXp': 20,
        'isSelesai': false,
      },
      {
        'id': 't2',
        'judul': 'Latihan menulis 2 baris Hiragana (A-Ko)',
        'bahasa': 'Jepang',
        'poinXp': 25,
        'isSelesai': false,
      },
      {
        'id': 't3',
        'judul': 'Dengarkan podcast Bahasa Inggris 10 menit',
        'bahasa': 'Inggris',
        'poinXp': 15,
        'isSelesai': true,
      },
      {
        'id': 't4',
        'judul': 'Baca 5 kalimat sapaan dalam Hangeul',
        'bahasa': 'Korea',
        'poinXp': 20,
        'isSelesai': false,
      },
      {
        'id': 't5',
        'judul': 'Ulangi kartu flashcard partikel dasar',
        'bahasa': 'Jepang',
        'poinXp': 15,
        'isSelesai': false,
      },
    ];
  }

  Future<List<dynamic>> fetchTipsBudayaJson() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      {
        'id': 'b1',
        'bahasa': 'Inggris',
        'ungkapan': 'Break a leg!',
        'arti': 'Semoga berhasil! (Bukan bermakna harfiah mematahkan kaki)',
        'catatanBudaya':
            'Sering dipakai di dunia pertunjukan atau sebelum teman menghadapi ujian/presentasi.',
      },
      {
        'id': 'b2',
        'bahasa': 'Jepang',
        'ungkapan': 'Otsukaresama desu (お疲れ様です)',
        'arti': 'Terima kasih atas kerja kerasnya',
        'catatanBudaya':
            'Wajib diucapkan kepada rekan kerja atau teman kelompok setelah menyelesaikan tugas bersama.',
      },
      {
        'id': 'b3',
        'bahasa': 'Korea',
        'ungkapan': 'Bap meogeosseoyo? (밥 먹었어요?)',
        'arti': 'Sudah makan?',
        'catatanBudaya':
            'Bukan sekadar pertanyaan lapar, melainkan bentuk sapaan hangat tanda peduli layaknya "Apa kabar?".',
      },
      {
        'id': 'b4',
        'bahasa': 'Inggris',
        'ungkapan': 'Piece of cake',
        'arti': 'Sesuatu yang sangat mudah dilakukan',
        'catatanBudaya':
            'Digunakan dalam percakapan santai saat menjelaskan tugas yang tidak sulit.',
      },
      {
        'id': 'b5',
        'bahasa': 'Jepang',
        'ungkapan': 'Itadakimasu (いただきます)',
        'arti': 'Selamat makan / Saya terima makanan ini dengan syukur',
        'catatanBudaya':
            'Diucapkan sambil menangkupkan kedua tangan sebelum mulai makan untuk menghormati bahan pangan dan pembuatnya.',
      },
    ];
  }
}