import '../../../core/network/http_service.dart';
import '../../../core/network/urls.dart';
import '../models/ip_lookup_model.dart';

Future<IpLookupModel?> getCurrentIpInfo() async {
  final data = await getAPICall(url: getCurrentIPUrl);
  if (data.isNotEmpty) {
    return IpLookupModel.fromJson(data);
  }
  return null;
}

Future<IpLookupModel?> getIpLookupInfo({required String ip}) async {
  final data = await getAPICall(url: '$baseUrl/$ip/json/');
  if (data.isNotEmpty) {
    return IpLookupModel.fromJson(data);
  }
  return null;
}
