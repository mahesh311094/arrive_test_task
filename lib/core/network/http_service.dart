import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final http.Client client;

  HttpService({http.Client? client}) : client = client ?? http.Client();

  // Http GET method call
  Future<Map<String, dynamic>> getAPICall({required String url}) async {
    final uri = Uri.parse(url);
    final response = await client.get(uri);
    debugPrint("--- status code:- ${response.statusCode}");
    debugPrint("--- response:- ${response.body}");
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return {};
  }
}
