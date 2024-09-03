import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpUtils {
  late String _baseurl;
  late Map<String, String> _baseHeaders;
  late Map<String, dynamic> _baseQueryParams;

  HttpUtils(
      {required String baseurl,
      Map<String, String>? baseheaders,
      Map<String, String>? baseQueryParams}) {
    _baseurl = baseurl;
    _baseHeaders = baseheaders ?? {};
    _baseQueryParams = baseQueryParams ?? {};
  }

  Future<HttpUtilsResponse> _generateResponse(_IHttpIp ip) async {

    String fullPath = "$_baseurl${ip.path}";

    if (ip.headers.isNotEmpty) {
      _baseHeaders.addAll(ip.headers);
    }

    if (ip.queryParams.isNotEmpty) {
      _baseQueryParams.addAll(ip.queryParams);
    }

    if (_baseQueryParams.isNotEmpty) {
      String queryParamasStr = Uri(queryParameters: _baseQueryParams).query;
      fullPath = "$fullPath?$queryParamasStr";
    }
    var uri = Uri.parse(fullPath);
    http.Request request = http.Request(ip.method, uri);
    request.body = ip.body;
    request.headers.addAll(_baseHeaders);

    HttpUtilsResponse httpResp = HttpUtilsResponse();

    print("baseHeader $_baseHeaders");

    http.Response response =
        await http.Response.fromStream(await request.send());
    httpResp.statusCode = response.statusCode;
    httpResp.body = jsonDecode(response.body) as Map<String, dynamic>;
    return httpResp;
  }

  Future<HttpUtilsResponse> get(IHttpIp ip) async {
    return _generateResponse(_IHttpIp(
        method: "GET",
        body: ip.body,
        headers: ip.headers,
        path: ip.path,
        queryParams: ip.queryParams));
  }

  Future<HttpUtilsResponse> post(IHttpIp ip) async {
    return _generateResponse(_IHttpIp(
        method: "POST",
        body: ip.body,
        headers: ip.headers,
        path: ip.path,
        queryParams: ip.queryParams));
  }

  Future<HttpUtilsResponse> put(IHttpIp ip) async {
    return _generateResponse(_IHttpIp(
        method: "PUT",
        body: ip.body,
        headers: ip.headers,
        path: ip.path,
        queryParams: ip.queryParams));
  }

  Future<HttpUtilsResponse> patch(IHttpIp ip) async {
    return _generateResponse(_IHttpIp(
        method: "PATCH",
        body: ip.body,
        headers: ip.headers,
        path: ip.path,
        queryParams: ip.queryParams));
  }

  Future<HttpUtilsResponse> delete(IHttpIp ip) async {
    return _generateResponse(_IHttpIp(
        method: "DELETE",
        body: ip.body,
        headers: ip.headers,
        path: ip.path,
        queryParams: ip.queryParams));
  }
}

class HttpUtilsResponse {
  late int statusCode;
  late Map<String, dynamic> body;

  HttpUtilsResponse({this.statusCode = 500, this.body = const {}});
}

enum HeaderContentType { json, plainText }

class IHttpIp {
  String path;
  String body;
  Map<String, String> headers;
  Map<String, dynamic> queryParams;

  IHttpIp(
      {this.path = "",
      this.body = "",
      this.headers = const <String, String>{},
      this.queryParams = const <String, dynamic>{}});
}

class _IHttpIp extends IHttpIp {
  final String method;

  _IHttpIp(
      {this.method = "GET",
      super.path,
      super.body,
      super.headers,
      super.queryParams});
}