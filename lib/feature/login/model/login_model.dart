import 'package:dio/dio.dart';

class LoginModel {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      Response response = await _dio.post(
        'https://yourapi.com/api/login',
        data: {
          'username': username,
          'password': password,
        },
      );
      return response.data;
    } on DioException catch (e) {
      if (e.response != null) {
        return {
          'success': false,
          'message': e.response?.data['message'] ?? 'Login failed',
        };
      } else {
        return {
          'success': false,
          'message': 'Network error: ${e.message}',
        };
      }
    }
  }
}
