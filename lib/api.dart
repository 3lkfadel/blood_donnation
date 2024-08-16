import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:blood_donnation/config/config.dart';
import 'package:blood_donnation/config/Notification.dart';

class ApiService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  ApiService() {
    _dio.options.baseUrl = ApiEndpoints.baseUrl; // Utiliser la constante de baseUrl
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

  Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  Future<Response> register(String name, String email, String numero, String password, String passwordConfirmation) async {
    final response = await _dio.post(
      ApiEndpoints.register, // Utiliser l'URL de l'API
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

    return response;
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData.containsKey('token')) {
          await _storage.write(key: 'auth_token', value: responseData['token']);
          print('Login successful');
        } else {
          throw Exception('Token non trouvé dans la réponse');
        }
      } else {
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
      throw Exception('Erreur de connexion!! verivifiez vos identifiants');
    }
  }

  Future<Response> getProfile() async {
    final response = await _dio.get(ApiEndpoints.profile);
    return response;
  }

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

    final response = await _dio.post(ApiEndpoints.updateProfile, data: formData);
    return response;
  }

  Future<Response> updateBloodGroup(String bloodGroup) async {
    try {
      final response = await _dio.post(
        ApiEndpoints.updateBloodGroup,
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

  Future<Map<String, dynamic>> getProfiles() async {
    try {
      final response = await _dio.get(ApiEndpoints.profile);
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      print('Error fetching profile: $e');
      rethrow;
    }
  }

  Future<Response> postAnnouncement(String title, String content, String raison, String typeSang, String centreSante) async {
    final FormData formData = FormData.fromMap({
      'titre': title,
      'description': content,
      'raison': raison,
      'TypeSang': typeSang,
      'CentreSante': centreSante,
    });

    final response = await _dio.post(
        ApiEndpoints.annonces, data: formData);
    return response;
  }

  //afficher les annonces
  Future<List<Map<String, dynamic>>> getAnnouncements() async {
    try {
      final response = await _dio.get(ApiEndpoints.annonces);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        // Convertir la liste dynamique en liste de cartes
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load announcements');
      }
    } catch (e) {
      print('Error fetching announcements: $e');
      rethrow;
    }
  }

  Future<List<AppNotification>> getNotifications() async {
    try {
      final response = await _dio.get(ApiEndpoints.notification);
      if (response.statusCode == 200) {
        // Assurez-vous que la réponse est une liste non vide
        List<dynamic> data = response.data as List<dynamic>;
        // Transformer la réponse en une liste d'objets AppNotification
        List<AppNotification> notifications = data.map((notification) {
          if (notification is Map<String, dynamic>) {
            return AppNotification.fromJson(notification);
          } else {
            throw Exception('Notification mal formatée');
          }
        }).toList();
        return notifications;
      } else {
        return []; // Retourner une liste vide en cas d'échec
      }
    } catch (e) {
      print('Erreur lors de la récupération des notifications: $e');
      return []; // Retourner une liste vide en cas d'erreur
    }
  }


  Future<void> sendFcmTokenToBackend(String token) async {
    try {
      final response = await Dio().post(ApiEndpoints.fcm, data: {
        'fcm_token': token,
      });

      if (response.statusCode == 200) {
        print('Token FCM envoyé avec succès.');
      } else if (response.statusCode == 302) {
        // Gérer la redirection
        print('Redirection détectée: ${response.headers}');
      } else {
        print('Erreur lors de l\'envoi du token FCM : ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        print('Exception Dio lors de l\'envoi du token FCM : ${e.message}');
      } else {
        print('Exception lors de l\'envoi du token FCM : $e');
      }
    }
  }


  Future<List<Map<String, dynamic>>> getAnnoncesHistory() async {
    try {
      final response = await _dio.get(ApiEndpoints.history);
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        // Convert dynamic list to a list of maps
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        throw Exception('Failed to load user announcements');
      }
    } catch (e) {
      print('Error fetching user announcements: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getAnnouncementDetails(int annonce_id) async {
    try {
      final response = await _dio.get('${ApiEndpoints.annonces}/$annonce_id');

      if (response.statusCode == 200) {
        // Retourner les détails de l'annonce
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Échec de la récupération des détails de l\'annonce: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la récupération des détails de l\'annonce: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getAnnonceByNotification(int notificationId) async {
    try {
      final response = await _dio.get('${ApiEndpoints.baseUrl}/notifications/$notificationId/annonce');

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Échec de la récupération de l\'annonce: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de la récupération de l\'annonce: $e');
      rethrow;
    }
  }

  Future<void> markNotificationAsRead(int notificationId) async {
    try {
      final response = await _dio.post('${ApiEndpoints.mark}/$notificationId');
      if (response.statusCode == 200) {
        print('Notification marquée comme lue.');
      } else {
        print('Erreur: ${response.data['message']}');
      }
    } catch (e) {
      print('Erreur lors de la mise à jour de la notification: $e');
    }
  }


}
