import 'package:flutter_riverpod/legacy.dart';

import '../models/ip_lookup_model.dart';
import '../repository/ip_lookup_repository.dart';

class IpLookupViewModel extends StateNotifier<IpLookupState> {
  final IpLookupRepository _repository;

  IpLookupViewModel(this._repository) : super(IpLookupState());

  // fetch current ip address, lat, long
  Future<void> fetchCurrentIpInfo() async {
    state = state.copyWith(isLoading: true, error: null);
    final ipInfo = await _repository.getCurrentIpInfo();
    if (ipInfo != null) {
      state = state.copyWith(isLoading: false, ipInfo: ipInfo);
    } else {
      state = state.copyWith(isLoading: false, error: "Failed to fetch data");
    }
  }

  //fetch lat, long from provided ip address
  Future<void> fetchIpLookupInfo({required String ip}) async {
    state = state.copyWith(isLoading: true, error: null);
    final ipInfo = await _repository.getIpLookupInfo(ip: ip);
    if (ipInfo != null) {
      state = state.copyWith(isLoading: false, ipInfo: ipInfo);
    } else {
      state = state.copyWith(isLoading: false, error: "Failed to fetch data");
    }
  }
}

class IpLookupState {
  final bool isLoading;
  final IpLookupModel? ipInfo;
  final String? error;

  IpLookupState({this.isLoading = false, this.ipInfo, this.error});

  IpLookupState copyWith({
    bool? isLoading,
    IpLookupModel? ipInfo,
    String? error,
  }) {
    return IpLookupState(
      isLoading: isLoading ?? this.isLoading,
      ipInfo: ipInfo ?? this.ipInfo,
      error: error,
    );
  }
}
