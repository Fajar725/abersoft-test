import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioConfig with DioMixin implements Dio {

  DioConfig() {
    options = BaseOptions(
      baseUrl: 'https://2e3d13cc-3d6d-4911-b94c-ba23cf332933.mock.pstmn.io/api/v1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(minutes: 1),
      responseType: ResponseType.json
    );

    interceptors
    .add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true
    ));

    httpClientAdapter = IOHttpClientAdapter();
    
    // String PEM='XXXXX'; // certificate content
    (httpClientAdapter as IOHttpClientAdapter).validateCertificate  = (cert, host, port) {
        return true;
    };
    
  }

}
