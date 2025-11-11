import 'package:arrive_test_task/features/ip_lookup/models/ip_lookup_model.dart';
import 'package:arrive_test_task/features/ip_lookup/repository/ip_lookup_repository.dart';
import 'package:arrive_test_task/features/ip_lookup/view_models/ip_lookup_viewmodel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock repository
class MockIpLookupRepository extends Mock implements IpLookupRepository {}

void main() {
  late MockIpLookupRepository mockRepository;
  late IpLookupViewModel viewModel;

  setUp(() {
    mockRepository = MockIpLookupRepository();
    viewModel = IpLookupViewModel(mockRepository);
  });

  final mockModel = IpLookupModel(
    ip: '8.8.8.8',
    latitude: 37.386,
    longitude: -122.0838,
  );

  group('IpLookupViewModel Tests', () {
    test(
      'fetchCurrentIpInfo sets ipInfo and disables loading on success',
      () async {
        // Arrange
        when(
          () => mockRepository.getCurrentIpInfo(),
        ).thenAnswer((_) async => mockModel);

        // Act
        await viewModel.fetchCurrentIpInfo();

        // Assert
        expect(viewModel.state.isLoading, false);
        expect(viewModel.state.ipInfo?.ip, '8.8.8.8');
        expect(viewModel.state.error, isNull);
      },
    );

    test(
      'fetchCurrentIpInfo sets error when repository returns null',
      () async {
        when(
          () => mockRepository.getCurrentIpInfo(),
        ).thenAnswer((_) async => null);

        await viewModel.fetchCurrentIpInfo();

        expect(viewModel.state.isLoading, false);
        expect(viewModel.state.ipInfo, isNull);
        expect(viewModel.state.error, 'Failed to fetch data');
      },
    );

    test('fetchIpLookupInfo sets ipInfo on success', () async {
      when(
        () => mockRepository.getIpLookupInfo(ip: any(named: 'ip')),
      ).thenAnswer((_) async => mockModel);

      await viewModel.fetchIpLookupInfo(ip: '8.8.8.8');

      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.ipInfo?.ip, '8.8.8.8');
      expect(viewModel.state.error, isNull);
    });

    test('fetchIpLookupInfo sets error when repository returns null', () async {
      when(
        () => mockRepository.getIpLookupInfo(ip: any(named: 'ip')),
      ).thenAnswer((_) async => null);

      await viewModel.fetchIpLookupInfo(ip: '8.8.8.8');

      expect(viewModel.state.isLoading, false);
      expect(viewModel.state.ipInfo, isNull);
      expect(viewModel.state.error, 'Failed to fetch data');
    });
  });
}
