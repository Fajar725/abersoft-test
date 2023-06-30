import 'dart:io';

import 'package:dio/dio.dart';

class ProductRequest {
    final String? productName;
    final File? productImage;
    final String? productDecription;

    ProductRequest({
        this.productName,
        this.productImage,
        this.productDecription,
    });

    Future<FormData> toFormData() async {
      final FormData formData = FormData();

      formData.fields.addAll([
        if(productName != null) MapEntry('productName', productName!),
        if(productDecription != null) MapEntry('productDecription', productDecription!),
      ]);

      if (productImage != null) {
        formData.files.add(
          MapEntry("productImage", await MultipartFile.fromFile(productImage!.path)),
        );
      }

      return formData;
    }
}