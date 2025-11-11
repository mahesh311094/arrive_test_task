import 'package:arrive_test_task/core/network/http_service.dart';
import 'package:arrive_test_task/features/ip_lookup/models/ip_lookup_model.dart';
import 'package:arrive_test_task/features/ip_lookup/repository/ip_lookup_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock HttpService
class MockHttpService extends Mock implements HttpService {}

void main() {
  late MockHttpService mockHttpService;
  late IpLookupRepository repository;

  setUp(() {
    mockHttpService = MockHttpService();
    repository = IpLookupRepository(mockHttpService);
  });

  final mockCurrentIpJson = {
    'ip': '123.123.123.123',
    'latitude': 10.0,
    'longitude': 20.0
  };

  final mockSpecificIpJson = {
    'ip': '8.8.8.8',
    'latitude': 15.0,
    'longitude': 25.0
  };

  test('getCurrentIpInfo returns IpLookupModel when data is present', () async {
    when(() => mockHttpService.getAPICall(url: any(named: 'url')))
        .thenAnswer((_) async => mockCurrentIpJson);

    final result = await repository.getCurrentIpInfo();
    expect(result, isA<IpLookupModel>());
    expect(result!.ip, '123.123.123.123');
    expect(result.latitude, 10.0);
    expect(result.longitude, 20.0);
  });

  test('getCurrentIpInfo returns null when data is empty', () async {
    when(() => mockHttpService.getAPICall(url: any(named: 'url')))
        .thenAnswer((_) async => {});

    final result = await repository.getCurrentIpInfo();
    expect(result, null);
  });

  test('getIpLookupInfo returns IpLookupModel when data is present', () async {
    when(() => mockHttpService.getAPICall(url: any(named: 'url')))
        .thenAnswer((_) async => mockSpecificIpJson);

    final result = await repository.getIpLookupInfo(ip: '8.8.8.8');
    expect(result, isA<IpLookupModel>());
    expect(result!.ip, '8.8.8.8');
    expect(result.latitude, 15.0);
    expect(result.longitude, 25.0);
  });

  test('getIpLookupInfo returns null when data is empty', () async {
    when(() => mockHttpService.getAPICall(url: any(named: 'url')))
        .thenAnswer((_) async => {});

    final result = await repository.getIpLookupInfo(ip: '8.8.8.8');
    expect(result, null);
  });
}
