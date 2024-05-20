import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AuthService {
  Future<Map<String, String>> loadCredentials() async {
    final String response =
        await rootBundle.loadString('assets/credentials.json');
    final data = await json.decode(response);
    return Map<String, String>.from(data);
  }
}
