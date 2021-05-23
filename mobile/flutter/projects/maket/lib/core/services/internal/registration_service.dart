import 'package:http/http.dart' as http;
import 'package:maket/core/services/internal/abstract_service.dart';
import 'package:maket/utils/http/http_headers_keys.dart';

class RegisterService extends AbstractApi {
  Future<String> register({Map<String, String> userInfo}) async {
    final Uri _url = this.url(path: AbstractApi.baseUserPath);
    final http.Response _response = await this.post(url: _url, body: userInfo);
    return _response.headers[HttpHeadersKeys.xToken];
  }
}
