class Product {
    final int? id;
    final String? name;
    final String? imageUrl;
    final String? productDescription;

    Product({
        this.id,
        this.name,
        this.imageUrl,
        this.productDescription,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        imageUrl: json["imageUrl"],
        productDescription: json["productDescription"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "productDescription": productDescription,
    };
}