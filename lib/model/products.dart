import 'package:abersoft_test/model/product.dart';

class Products {
    final List<Product>? bestProduct;
    final List<Product>? allProduct;

    Products({
        this.bestProduct,
        this.allProduct,
    });

    factory Products.fromJson(Map<String, dynamic> json) => Products(
        bestProduct: json["bestProduct"] == null ? [] : List<Product>.from(json["bestProduct"]!.map((x) => Product.fromJson(x))),
        allProduct: json["allProduct"] == null ? [] : List<Product>.from(json["allProduct"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "bestProduct": bestProduct == null ? [] : List<dynamic>.from(bestProduct!.map((x) => x.toJson())),
        "allProduct": allProduct == null ? [] : List<dynamic>.from(allProduct!.map((x) => x.toJson())),
    };
}