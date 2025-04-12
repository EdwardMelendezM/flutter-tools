import 'dart:io';

import 'package:testapp/auth/domain/auth_entity.dart';
import 'package:testapp/auth/domain/auth_repository.dart';
import '../../../../shared/api/api_client.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRepositoryRest extends ApiClient implements AuthRepository {
  @override
  Future<LoginResponse?> login(LoginBody loginEntity) async {
    try {
      String baseUrl = ApiClient.getEndpoint('/api/v1/auth/login');
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: loginEntity.toJson(),
      );

      return LoginResponse.fromJson(json.decode(response.body));
    } catch (e) {
      return null;
    }
  }
}
