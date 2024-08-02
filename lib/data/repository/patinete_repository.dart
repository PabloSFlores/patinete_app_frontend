import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/patinete_model.dart';

class PatineteRepository {
  final String apiUrl;

  PatineteRepository({
    required this.apiUrl,
  });

  Future<void> crearPatinete(PatineteModel patinete) async {
    final response = await http.post(
      Uri.parse('$apiUrl/crear_patinete'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(patinete.toJson()..remove('id')),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al crear patinete.');
    }
  }

  Future<PatineteModel> consultarPatinete(String id) async {
    final response = await http.get(
      Uri.parse('$apiUrl/consultar_patinete/$id'),
      headers: <String, String>{
        //'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return PatineteModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Error al cargar patinete.');
    }
  }

  Future<void> actualizarPatinete(PatineteModel patinete) async {
    final response = await http.put(
      Uri.parse('$apiUrl/actualizar_patinete'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
      body: jsonEncode(patinete.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar patinete.');
    }
  }

  Future<void> eliminarPatinete(String id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/eliminar_patinete/$id'),
      headers: <String, String>{
        //'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar patinete.');
    }
  }

  Future<List<PatineteModel>> consultarPatinetes() async {
    final response = await http.get(
      Uri.parse('$apiUrl/consultar_patinetes'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
      Iterable l = json.decode(response.body)['data'];
      return List<PatineteModel>.from(
          l.map((model) => PatineteModel.fromJson(model)));
    } else {
      throw Exception('Error al cargar patinetes.');
    }
  }
}
