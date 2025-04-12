class ApiClient {
  static const String baseUrl = 'https://api.example.com';

  static String getEndpoint(String endpoint) {
    return '$baseUrl$endpoint';
  }
}
