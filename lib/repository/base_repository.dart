import 'package:abersoft_test/infra/api/dio_handler.dart';
import 'package:abersoft_test/infra/api/dio_options.dart';
import 'package:abersoft_test/infra/enum/preferences_enum.dart';
import 'package:abersoft_test/infra/local/preferences.dart';
import 'package:abersoft_test/model/login_request.dart';
import 'package:abersoft_test/model/login_response.dart';
import 'package:abersoft_test/model/product.dart';
import 'package:abersoft_test/model/product_request.dart';
import 'package:abersoft_test/model/products.dart';
import 'package:abersoft_test/repository/base_repository_interface.dart';
import 'package:dio/dio.dart';

class BaseRepository implements BaseRepositoryInterface {
  final DioOptions _dioOptions = DioOptions.init();

  static BaseRepository? _baseRepository;

  BaseRepository._();

  static BaseRepository init(){
    _baseRepository ??= BaseRepository._();

    return _baseRepository!;
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    try {

      var response = await _dioOptions.postWithJson(
        "login",
        json: request.toJson()
      );

      await EnumPreferences.instance().setPreferences(PreferencesEnum.token, response.data);

      return LoginResponse.fromJson(response.data);

    } on DioException catch(d){
      throw DioHandler.errorHandlers(d);
    }
  }

  @override
  Future<Products> getProducts() async {
    try {
      String? pref = await EnumPreferences.instance().getPreferences(PreferencesEnum.token);

      var response = await _dioOptions.getWithAuthParam(
        "products",
        pref!
      );

      return Products.fromJson(response.data);

    } on DioException catch(d){
      throw DioHandler.errorHandlers(d);
    }
  }

  @override
  Future<bool> logout() async {

    return await EnumPreferences.instance().removePreferences(PreferencesEnum.token);

  }

  @override
  Future<Product> createProduct(ProductRequest request) async {
    try {
      String? pref = await EnumPreferences.instance().getPreferences(PreferencesEnum.token);

      var response = await _dioOptions.postWithAuthFormData(
        "products",
        pref!,
        formData: await request.toFormData(),
      );

      return Product.fromJson(response.data);

    } on DioException catch(d){
      throw DioHandler.errorHandlers(d);
    }
  }
  
}