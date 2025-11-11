import 'package:arrive_test_task/core/widgets/map_widget.dart';
import 'package:arrive_test_task/features/ip_lookup/models/ip_lookup_model.dart';
import 'package:arrive_test_task/features/ip_lookup/providers/ip_lookup_provider.dart';
import 'package:arrive_test_task/features/ip_lookup/repository/ip_lookup_repository.dart';
import 'package:arrive_test_task/features/ip_lookup/screens/ip_lookup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIpLookupRepository extends Mock implements IpLookupRepository {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockIpLookupRepository mockRepository;

  setUp(() {
    mockRepository = MockIpLookupRepository();
  });

  Widget makeTestableWidget() {
    return ProviderScope(
      overrides: [ipLookupRepositoryProvider.overrideWithValue(mockRepository)],
      child: MaterialApp(home: IpLookupScreen()),
    );
  }

  testWidgets('Full integration: lookup and use my IP flow', (tester) async {
    final ipModel1 = IpLookupModel(
      ip: '8.8.8.8',
      latitude: 10.0,
      longitude: 20.0,
    );
    final ipModel2 = IpLookupModel(
      ip: '1.2.3.4',
      latitude: 11.0,
      longitude: 22.0,
    );

    // Mock repository responses
    when(
      () => mockRepository.getIpLookupInfo(ip: any(named: 'ip')),
    ).thenAnswer((_) async => ipModel1);
    when(
      () => mockRepository.getCurrentIpInfo(),
    ).thenAnswer((_) async => ipModel2);

    await tester.pumpWidget(makeTestableWidget());

    // ---- Test entering IP and tapping Lookup ----
    await tester.enterText(find.byType(TextField), '8.8.8.8');
    await tester.tap(find.text('Lookup'));
    await tester.pumpAndSettle();

    // MapWidget should update
    expect(find.byType(MapWidget), findsOneWidget);
    expect(find.text('8.8.8.8'), findsOneWidget);

    // ---- Test tapping Use My IP ----
    await tester.tap(find.text('Use My IP'));
    await tester.pumpAndSettle();

    // TextField updates with current IP
    expect(find.text('1.2.3.4'), findsOneWidget);
    expect(find.byType(MapWidget), findsOneWidget);
  });

  testWidgets('Shows error snackbar when Lookup is empty', (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    await tester.tap(find.text('Lookup'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Please enter an IP address'), findsOneWidget);
  });
}
