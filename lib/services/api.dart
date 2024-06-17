import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = 'http://192.168.1.191:8000';

  static Future getPlants() {
    return http.get(Uri.parse('$baseUrl/plants'));
  }

  static Future getSellers() {
    return http.get(Uri.parse('$baseUrl/sellers'));
  }
}
