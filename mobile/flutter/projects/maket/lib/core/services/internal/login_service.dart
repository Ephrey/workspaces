import 'package:http/http.dart' as http;
import 'package:maket/core/services/internal/abstract_service.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/local_storage.dart';

class LoginService extends AbstractApi {
  Future<String> login({Map<String, String> userInfo}) async {
    final Uri _url = this.url(path: AbstractApi.loginPath);

    String _token = await LocalStorage.get(HttpHeadersKeys.xToken) ?? '';

    final http.Response _response = await this.post(
      url: _url,
      body: userInfo,
      headers: {HttpHeadersKeys.xToken: _token},
    );
    return _response.headers[HttpHeadersKeys.xToken];
  }
}
