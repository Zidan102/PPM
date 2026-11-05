import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post.dart';

class PostService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  static const Duration timeoutDuration = Duration(seconds: 5);

  // Mengambil daftar pengumuman
  Future<List<Post>> fetchPosts() async {
    try {
      final url = Uri.parse('$baseUrl/posts');
      final response = await http.get(url).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => Post.fromJson(item)).toList();
      } else {
        throw Exception('Gagal memuat pengumuman (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Koneksi internet terputus atau gagal terhubung ke server.');
    }
  }

  // Mengambil daftar komentar berdasarkan ID post
  Future<List<dynamic>> fetchComments(int postId) async {
    try {
      final url = Uri.parse('$baseUrl/posts/$postId/comments');
      final response = await http.get(url).timeout(timeoutDuration);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Gagal memuat komentar (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Gagal memuat komentar. Periksa koneksi internet Anda.');
    }
  }

  // Mengirim pengumuman baru (POST)
  Future<Post> createPost(String title, String body, int userId) async {
    try {
      final url = Uri.parse('$baseUrl/posts');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'title': title,
          'body': body,
          'userId': userId,
        }),
      ).timeout(timeoutDuration);

      if (response.statusCode == 201) {
        return Post.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Gagal membuat pengumuman (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception('Gagal mengirim data. Periksa koneksi internet Anda.');
    }
  }
}