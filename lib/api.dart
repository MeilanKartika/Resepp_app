import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'https://6617c206ed6b8fa43483b2c1.mockapi.io/api/v1';
  static const String endpoint = '/tambahresep';

  static Future<List<Map<String, dynamic>>> getResep() async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load resep');
    }
  }

  static Future<void> addResep(Map<String, dynamic> resep) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(resep),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add resep');
    }
  }

  static Future<void> updateResep(String id, Map<String, dynamic> resep) async {
    final response = await http.put(
      Uri.parse('$baseUrl$endpoint/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(resep),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update resep');
    }
  }

  static Future<void> deleteResep(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl$endpoint/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete resep');
    }
  }
}
