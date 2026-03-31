import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/karakter.dart';

class LayananApi {
  static const String _baseUrl = 'https://thronesapi.com/api/v2/Characters';

  Future<List<Karakter>> fetchCharacters() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
      return data
          .map((item) => Karakter.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    throw Exception(
      'Gagal memuat data karakter. Status code: ${response.statusCode}',
    );
  }
}
