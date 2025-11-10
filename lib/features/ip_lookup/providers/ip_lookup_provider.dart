import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/network/http_service.dart';
import '../repository/ip_lookup_repository.dart';
import '../view_models/ip_lookup_viewmodel.dart';

/// HttpService provider
final httpServiceProvider = Provider<HttpService>((ref) => HttpService());

/// Repository provider
final ipLookupRepositoryProvider = Provider<IpLookupRepository>((ref) {
  final httpService = ref.read(httpServiceProvider);
  return IpLookupRepository(httpService);
});

/// ViewModel provider
final ipLookupViewModelProvider =
    StateNotifierProvider<IpLookupViewModel, IpLookupState>((ref) {
      final repository = ref.read(ipLookupRepositoryProvider);
      return IpLookupViewModel(repository);
    });
