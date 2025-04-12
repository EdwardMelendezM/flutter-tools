class LoginBody {
  final String email;
  final String password;

  LoginBody({
    required this.email,
    required this.password,
  });

  toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class LoginResponse {
  final String token;
  final String refreshToken;
  final String userId;

  LoginResponse({
    required this.token,
    required this.refreshToken,
    required this.userId,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      refreshToken: json['refresh_token'],
      userId: json['user_id'],
    );
  }

  fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      refreshToken: json['refresh_token'],
      userId: json['user_id'],
    );
  }
}

class Response<T> {
  final T? data;
  final String? error;

  Response({this.data, this.error});

  bool get isSuccess => error == null;

  @override
  String toString() {
    return 'Response{data: $data, error: $error}';
  }
}
