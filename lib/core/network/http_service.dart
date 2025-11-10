import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getAPICall({required String url}) async {
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  debugPrint("--- status code:- ${response.statusCode}");
  debugPrint("--- response:- ${response.body}");
  if (response.statusCode == 200) {
    return json.decode(response.body);
  }
  return {};
}
