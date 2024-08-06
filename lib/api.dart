import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  final String baseUrl = 'http://192.168.11.120:8000/api';

  ApiService() {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await _storage.read(key: 'auth_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));
  }

  // Method to store token securely
  Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  Future<Response> register(String name, String email, String numero, String password, String passwordConfirmation) async {
    final response = await _dio.post(
      '/register',
      data: {
        'name': name,
        'email': email,
        'telephone': numero,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );

    if (response.statusCode == 201) {
      print('Registration successful');
    } else {
      throw Exception('Failed to register: ${response.data['message']}');
    }

    return response; // Retourne la réponse ici
  }



  Future<void> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        // verifier que le token est présent dans la réponse
        if (responseData.containsKey('token')) {
          await _storage.write(key: 'auth_token', value: responseData['token']);
          print('Login successful');
        } else {
          throw Exception('Token non trouvé dans la réponse');
        }
      } else {
        // Gérer les réponses inattendues
        final responseData = response.data;
        if (responseData != null && responseData is Map<String, dynamic>) {
          final errorMessage = responseData['message'] ?? 'Échec de la connexion';
          throw Exception(errorMessage);
        } else {
          throw Exception('Échec de la connexion avec statut: ${response.statusCode}');
        }
      }
    } on DioException catch (e) {
      if (e.response != null) {
        print('Erreur réseau: ${e.response?.data}');
        throw Exception('Erreur réseau: ${e.response?.data}');
      } else {
        print('Erreur réseau sans réponse');
        throw Exception('Erreur réseau');
      }
    } catch (e) {
      print('Erreur inattendue: $e');
      throw Exception('Erreur inattendue');
    }
  }



  // Obtenir les détails du profil utilisateur
  Future<Response> getProfile() async {
    final response = await _dio.get('/profile');
    return response;
  }

  // Mettre à jour le profil utilisateur
  Future<Response> updateProfile({
    required String name,
    required String email,
    required String phone,
    String? imagePath,
    String? gender,
    String? ville,
    String? age,
    String? pays,
  }) async {
    final FormData formData = FormData.fromMap({
      'name': name,
      'email': email,
      'telephone': phone,
      if (imagePath != null) 'image': await MultipartFile.fromFile(imagePath),
      if (gender != null) 'sexe': gender,
      if (ville != null) 'ville': ville,
      if (age != null) 'age': age,
      if (pays != null) 'pays': pays,
    });

    final response = await _dio.put('/profile', data: formData);
    return response;
  }

  // Method to update the user's blood group
  Future<Response> updateBloodGroup(String bloodGroup) async {
    try {
      final response = await _dio.post(
        '/groupsanguin',
        data: {'blood_group': bloodGroup},
      );

      if (response.statusCode == 200) {
        print('Groupe sanguin mis à jour');
      } else {
        throw Exception('Échec de la mise à jour du groupe sanguin: ${response.data['message']}');
      }

      return response;
    } catch (e) {
      print('Erreur lors de la mise à jour du groupe sanguin: $e');
      rethrow;
    }
  }

}



