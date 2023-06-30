import 'package:abersoft_test/infra/enum/custom_exception_enum.dart';
import 'package:abersoft_test/model/base_error_response.dart';
import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';

class DioHandler {

  static Exception errorHandlers(DioException d) {
    if(d.type == DioExceptionType.badResponse){
      Response response = d.response!;

      if(response.statusCode! == 403){
        BaseErrorResponse responseModel = BaseErrorResponse.fromJson(response.data);
        String message = responseModel.message ?? '';

        return ForbiddenException(message);
      } else if (response.statusCode! >= 406) {
        BaseErrorResponse responseModel = BaseErrorResponse.fromJson(response.data);
        String message = responseModel.message ?? '';
        
        return NotAcceptableException(message);
      } else {
        return UnexpectedException('UNEXCPECTED_MESSAGE'.tr);
      }
    } else {
      return UnexpectedException('UNEXCPECTED_MESSAGE'.tr);
    }
  }
  
}