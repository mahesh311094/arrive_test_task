import 'dart:convert';

import 'package:arrive_test_task/core/network/http_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient client;
  late HttpService service;

  setUp(() {
    client = MockClient();
    service = HttpService(client: client);
  });

  test('getAPICall returns JSON on 200 response', () async {
    final jsonResponse = {'ip': '123.123.123.123'};
    when(
      () => client.get(Uri.parse('https://ipapi.co/json/')),
    ).thenAnswer((_) async => http.Response(json.encode(jsonResponse), 200));

    final result = await service.getAPICall(url: 'https://ipapi.co/json/');
    expect(result['ip'], '123.123.123.123');
  });

  test('getAPICall returns {} on non-200', () async {
    when(
      () => client.get(Uri.parse('https://ipapi.co/json/')),
    ).thenAnswer((_) async => http.Response('Error', 404));

    final result = await service.getAPICall(url: 'https://ipapi.co/json/');
    expect(result, {});
  });
}
