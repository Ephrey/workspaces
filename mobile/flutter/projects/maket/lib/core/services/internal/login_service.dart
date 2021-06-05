import 'package:http/http.dart' as http;
import 'package:maket/core/services/internal/abstract_service.dart';
import 'package:maket/utils/http/http_headers_keys.dart';

class LoginService extends AbstractApi {
  Future<String> login({Map<String, String> userInfo}) async {
    final Uri _url = this.url(path: AbstractApi.loginPath);

    final http.Response _response = await this.post(
      url: _url,
      body: userInfo,
      headers: {HttpHeadersKeys.xToken: await this.getToken()},
    );
    return _response.headers[HttpHeadersKeys.xToken];
  }
}
