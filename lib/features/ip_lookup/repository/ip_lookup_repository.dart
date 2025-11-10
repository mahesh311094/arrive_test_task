import '../../../core/network/http_service.dart';
import '../../../core/network/urls.dart';
import '../models/ip_lookup_model.dart';

class IpLookupRepository {
  final HttpService httpService;

  IpLookupRepository(this.httpService);

  // fetch current ip address, lat, long
  Future<IpLookupModel?> getCurrentIpInfo() async {
    final data = await httpService.getAPICall(url: getCurrentIPUrl);
    if (data.isNotEmpty) {
      return IpLookupModel.fromJson(data);
    }
    return null;
  }

  //fetch lat, long from provided ip address
  Future<IpLookupModel?> getIpLookupInfo({required String ip}) async {
    final data = await httpService.getAPICall(url: '$baseUrl/$ip/json/');
    if (data.isNotEmpty) {
      return IpLookupModel.fromJson(data);
    }
    return null;
  }
}
