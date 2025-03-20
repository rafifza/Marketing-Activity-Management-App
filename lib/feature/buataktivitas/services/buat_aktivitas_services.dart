import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mam/feature/buataktivitas/model/buat_aktivitas_model.dart';

class AktivitasService {
  final Dio _dio = Dio();

  Future<Response> createAktivitas(AktivitasModel aktivitas) async {
    try {
      final response = await _dio.post(
        'blabla/api/aktivitas',
        data: json.encode(aktivitas),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create aktivitas: $e');
    }
  }
}
