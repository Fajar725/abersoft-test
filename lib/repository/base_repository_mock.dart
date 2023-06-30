import 'package:abersoft_test/infra/api/dio_handler.dart';
import 'package:abersoft_test/infra/enum/custom_exception_enum.dart';
import 'package:abersoft_test/infra/enum/preferences_enum.dart';
import 'package:abersoft_test/infra/local/preferences.dart';
import 'package:abersoft_test/model/login_request.dart';
import 'package:abersoft_test/model/login_response.dart';
import 'package:abersoft_test/model/product.dart';
import 'package:abersoft_test/model/product_request.dart';
import 'package:abersoft_test/model/products.dart';
import 'package:abersoft_test/repository/base_repository_interface.dart';
import 'package:dio/dio.dart';

class BaseRepositoryMock implements BaseRepositoryInterface {
  static BaseRepositoryMock? _baseRepository;

  BaseRepositoryMock._();

  static BaseRepositoryMock init(){
    _baseRepository ??= BaseRepositoryMock._();

    return _baseRepository!;
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    await Future.delayed(const Duration(seconds: 3));

    if(request.username != 'abersoft' || request.password != '12345678') {
      throw const ForbiddenException('Username or password incorect');
    }

    await EnumPreferences.instance().setPreferences(PreferencesEnum.token, '987654321');

    return LoginResponse(token: '987654321');

  }

  @override
  Future<Products> getProducts() async {
    await Future.delayed(const Duration(seconds: 3));

    String? pref = await EnumPreferences.instance().getPreferences(PreferencesEnum.token);

    if(pref != '987654321') {
      throw const ForbiddenException('You dont have access to this routes');
    }

    return Products.fromJson({
      "bestProduct": [
        {
          "id":1,
          "name":"Product 1",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 1"
        },
        {
          "id":2,
          "name":"Product 2",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 2"
        },
        {
          "id":3,
          "name":"Product 3",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 3"
        }
      ],
      "allProduct": [
        {
          "id":1,
          "name":"Product 1",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 1"
        },
        {
          "id":2,
          "name":"Product 2",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 2"
        },
        {
          "id":3,
          "name":"Product 3",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 3"
        },
        {
          "id":4,
          "name":"Product 4",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 4"
        },
        {
          "id":5,
          "name":"Product 5",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 5"
        },
        {
          "id":6,
          "name":"Product 6",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 6"
        },
        {
          "id":7,
          "name":"Product 7",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 7"
        },
        {
          "id":8,
          "name":"Product 8",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 8"
        },
        {
          "id":9,
          "name":"Product 9",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 9"
        },
        {
          "id":10,
          "name":"Product 10",
          "imageUrl":"https://via.placeholder.com/100x100",
          "productDescription":"this is product 10"
        }
      ],
    });

  }

  @override
  Future<bool> logout() async {

    return await EnumPreferences.instance().removePreferences(PreferencesEnum.token);

  }

  @override
  Future<Product> createProduct(ProductRequest request) async {
    await Future.delayed(const Duration(seconds: 3));
    
    try {
      String? pref = await EnumPreferences.instance().getPreferences(PreferencesEnum.token);

      if(pref != '987654321') {
        throw const ForbiddenException('You dont have access to this routes');
      }

      if(request.productName == null || request.productImage == null || request.productDecription == null) {
        throw const NotAcceptableException('required all fields');
      }

      return Product(name: request.productName, imageUrl: 'https://mockup.com', productDescription: request.productDecription);

    } on DioException catch(d){
      throw DioHandler.errorHandlers(d);
    }
  }
  
}