abstract class AbstractApi {
  static const String endpoint = 'localhost:3000';
  static const String defaultPath = '/api/';

  Uri url({String path: '', Map<String, dynamic> params: const {}}) {
    return Uri.http(endpoint, defaultPath + path, params);
  }
}
