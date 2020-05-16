import 'package:bytebank/http/interceptors/LoggingInterceptor.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';

class WebClient {
  HttpClientWithInterceptor geClient() {
    return HttpClientWithInterceptor.build(
      interceptors: [
        LoggingInterceptor(),
      ],
      requestTimeout: Duration(seconds: 5),
    );
  }
}
