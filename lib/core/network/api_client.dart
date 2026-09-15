/// Base placeholder for HTTP network client (e.g. Dio or http wrapper).
/// Shared across feature data sources.
class ApiClient {
  final String baseUrl;

  ApiClient({this.baseUrl = 'https://api.example.com'});

  Future<dynamic> get(String endpoint) async {
    // TODO: Implement GET request logic using HTTP/Dio
  }

  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    // TODO: Implement POST request logic using HTTP/Dio
  }
}
