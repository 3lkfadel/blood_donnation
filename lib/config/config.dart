class ApiEndpoints {
  static const String baseUrl = 'http://192.168.11.102:8000/api';
  static const String register = '$baseUrl/register';
  static const String login = '$baseUrl/login';
  static const String profile = '$baseUrl/profile';
  static const String updateProfile = '$baseUrl/updateprofile';
  static const String updateBloodGroup = '$baseUrl/groupsanguin';
  static const String annonces = '$baseUrl/annonces';
  static const String fcm = '$baseUrl/fcm';
  static const String notification = '$baseUrl/notifications';
  static const String mark = '$baseUrl/mark';
  static const String history = '$baseUrl/historiques';
  static const String centre = '$baseUrl/centres';

  static const String imageurl = 'http://192.168.11.102:8000/storage/';

  static const String don = '$baseUrl/dons';
  static const String verify = '$baseUrl/verify';

  static String donsForAnnonce(int annonceId) {
    return '$baseUrl/annonce/$annonceId/dons';
  }

  static String annonceEtat(int annonceId) {
    return '$baseUrl/annonceEtat/$annonceId';
  }

  static String myDon = "$baseUrl/myDon";
  static String donConfirmation(int donId) {
    return '$baseUrl/confirmDon/$donId';
  }

  static String donAnnulation(int donId) {
    return '$baseUrl/annulerDon/$donId';
  }

  static String pub = "$baseUrl/pub";
  static const String passwordlink = "$baseUrl/passwordlink";
  static String passwordreset = "$baseUrl/passwordreset";
}
