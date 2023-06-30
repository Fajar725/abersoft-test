import 'package:abersoft_test/model/login_request.dart';
import 'package:abersoft_test/model/login_response.dart';
import 'package:abersoft_test/model/product.dart';
import 'package:abersoft_test/model/product_request.dart';
import 'package:abersoft_test/model/products.dart';

abstract class BaseRepositoryInterface {

  Future<LoginResponse> login(LoginRequest request);

  Future<Products> getProducts();

  Future<Product> createProduct(ProductRequest request);

  Future<bool> logout();

}