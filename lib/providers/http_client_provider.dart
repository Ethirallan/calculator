import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

final httpClientProvider = Provider<http.BaseClient>((ref) {
  return AuthenticatedHttpClient(ref);
});

class AuthenticatedHttpClient extends http.BaseClient {
  AuthenticatedHttpClient(this.ref);

  final Ref ref;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    String token = dotenv.env['API_KEY'] ?? '';

    if (token != '') {
      request.headers.putIfAbsent('authorization', () => 'Bearer $token');
    }
    return request.send();
  }
}
