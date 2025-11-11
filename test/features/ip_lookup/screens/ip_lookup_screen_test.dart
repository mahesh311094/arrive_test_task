import 'package:arrive_test_task/core/widgets/map_widget.dart';
import 'package:arrive_test_task/features/ip_lookup/models/ip_lookup_model.dart';
import 'package:arrive_test_task/features/ip_lookup/providers/ip_lookup_provider.dart';
import 'package:arrive_test_task/features/ip_lookup/repository/ip_lookup_repository.dart';
import 'package:arrive_test_task/features/ip_lookup/screens/ip_lookup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // make sure legacy import if used
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockIpLookupRepository extends Mock implements IpLookupRepository {}

void main() {
  late MockIpLookupRepository mockRepository;

  setUp(() {
    mockRepository = MockIpLookupRepository();
  });

  Widget makeTestableWidget() {
    return ProviderScope(
      overrides: [
        ipLookupRepositoryProvider.overrideWithValue(mockRepository),
      ],
      child: MaterialApp(home: IpLookupScreen()),
    );
  }

  testWidgets('Lookup button fetches IP info', (tester) async {
    final testModel =
    IpLookupModel(ip: '8.8.8.8', latitude: 10.0, longitude: 20.0);

    when(() => mockRepository.getIpLookupInfo(ip: any(named: 'ip')))
        .thenAnswer((_) async => testModel);

    await tester.pumpWidget(makeTestableWidget());

    await tester.enterText(find.byType(TextField), '8.8.8.8');
    await tester.tap(find.text('Lookup'));
    await tester.pump();
    await tester.pumpAndSettle();

    // Check that the TextField still has correct value
    expect(find.text('8.8.8.8'), findsOneWidget);
    // Check MapWidget exists
    expect(find.byType(MapWidget), findsOneWidget);
  });

  testWidgets('Use My IP button fetches current IP', (tester) async {
    final testModel =
    IpLookupModel(ip: '1.2.3.4', latitude: 11.0, longitude: 22.0);

    when(() => mockRepository.getCurrentIpInfo()).thenAnswer((_) async => testModel);

    await tester.pumpWidget(makeTestableWidget());

    await tester.tap(find.text('Use My IP'));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.text('1.2.3.4'), findsOneWidget);
    expect(find.byType(MapWidget), findsOneWidget);
  });

  testWidgets('Shows error SnackBar when IP field is empty', (tester) async {
    await tester.pumpWidget(makeTestableWidget());

    await tester.tap(find.text('Lookup'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Please enter an IP address'), findsOneWidget);
  });
}