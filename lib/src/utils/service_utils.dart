import 'dart:convert';

import 'package:amdha_communication_lib/src/contracts/meetings.dart';
import 'package:amdha_communication_lib/src/contracts/tokens.dart';
import 'package:amdha_communication_lib/src/enums/azure_meeting_role.dart';
import 'package:amdha_communication_lib/src/utils/http_utils.dart';

class ServiceUtils {
  String basePath;
  String bearerToken;

  late HttpUtils _serviceHttpUtils;

  ServiceUtils({required this.basePath, required this.bearerToken}) {
    _serviceHttpUtils = HttpUtils(baseurl: basePath, baseheaders: {
      'Authorization': bearerToken,
      'Content-type': "application/json"
    });
  }

  Future<AzureTokens> getAzureTokens(String participantId) async {
    IHttpIp ip = IHttpIp(
        path: "/api/azure/tokens",
        queryParams: {'participant_id': participantId});
    var result = await _serviceHttpUtils.get(ip);
    if (result.statusCode == 200) {
      return AzureTokens.fromMap(result.body);
    } else {
      throw "Error @getAzureTokens ${result.statusCode}";
    }
  }

  Future<DyteTokens> getDyteMeetingTokens(String participantId,
      String meetingId, String? participantName, String? preset) async {
    IHttpIp ip = IHttpIp(
        path: "/api/dyte/tokens",
        body: jsonEncode({
          "meeting_id": meetingId,
          "participant_name": participantName ?? "John doe",
          "participant_id": participantId,
          "preset": preset
        }));
    var result = await _serviceHttpUtils.post(ip);
    if (result.statusCode == 200) {
      return DyteTokens.fromMap(result.body);
    } else {
      throw "Error @getAzureTokens ${result.statusCode}";
    }
  }

  Future<AzureAmdhaMeeting> createAzureMeeting(
      {DateTime? start, DateTime? end, AzureMeetingRole? role}) async {
    Map<String, dynamic> body = {};
    if (start != null) {
      body.addAll({"start": start.toIso8601String()});
    }
    if (end != null) {
      body.addAll({"end": end.toIso8601String()});
    }
    if (role != null) {
      body.addAll({"role": role.value});
    }
    IHttpIp ip = IHttpIp(path: "/api/azure/meetings", body: jsonEncode(body));
    var result = await _serviceHttpUtils.post(ip);
    if (result.statusCode == 200) {
      return AzureAmdhaMeeting.fromMap(result.body);
    } else {
      throw "Error @createAzureMeeting ${result.statusCode}";
    }
  }

  Future<AzureAmdhaMeeting> createDyteMeeting(String? title) async {
    title = title ?? "Default Dyte Meeting";
    IHttpIp ip =
        IHttpIp(path: "/api/dyte/meetings", body: jsonEncode({"title": title}));
    var result = await _serviceHttpUtils.post(ip);
    if (result.statusCode == 200) {
      return AzureAmdhaMeeting.fromMap(result.body);
    } else {
      throw "Error @createDyteMeeting ${result.statusCode}";
    }
  }

  Future<AzureAmdhaMeeting> deactivateDyteMeeting(String meetingId) async {
    IHttpIp ip = IHttpIp(
        path: "/api/dyte/meetings", queryParams: {'meeting_id': meetingId});
    var result = await _serviceHttpUtils.delete(ip);
    if (result.statusCode == 200) {
      return AzureAmdhaMeeting.fromMap(result.body);
    } else {
      throw "Error @deactivateDyteMeeting ${result.statusCode}";
    }
  }
}
