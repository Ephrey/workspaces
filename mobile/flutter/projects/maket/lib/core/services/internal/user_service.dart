import 'package:http/http.dart' as http;
import 'package:maket/core/services/internal/abstract_service.dart';
import 'package:maket/utils/http/http_headers_keys.dart';
import 'package:maket/utils/http/http_responses.dart';

class UserService extends AbstractApi {
  Future<String> login({Map<String, String> userInfo}) async {
    final http.Response _response = await this.post(
      url: this.url(path: AbstractApi.loginPath),
      body: userInfo,
      headers: {HttpHeadersKeys.xToken: await this.getToken()},
    );
    return _response.headers[HttpHeadersKeys.xToken];
  }

  Future<HttpResponse> verifyEmail({String email}) async {
    final http.Response _response = await this.post(
      url: this.url(path: AbstractApi.verifyEmailPath),
      body: {"email": email},
    );

    return Response.build(code: _response.statusCode, message: _response.body);
  }

  Future<HttpResponse> verifyOtpCode({String otpCode, String email}) async {
    final http.Response _response = await this.post(
      url: this.url(path: AbstractApi.verifyOtpCodePath),
      body: {"otp": otpCode, "email": email},
    );

    return Response.build(code: _response.statusCode, message: _response.body);
  }

  Future<HttpResponse> updatePassword({
    String newPassword,
    String email,
  }) async {
    final http.Response _response = await this.put(
      url: this.url(path: AbstractApi.updatePasswordPath),
      body: {"password": newPassword, "email": email},
    );

    return Response.build(
      data: _response.headers[HttpHeadersKeys.xToken],
      code: _response.statusCode,
      message: _response.body,
    );
  }
}
