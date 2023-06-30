import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

Future<File> rezise(File image) async {
    final File originalFile = image;
    Uint8List imageBytes = await originalFile.readAsBytes();

    final img.Image originalImage = img.decodeImage(imageBytes)!;

    final int orientation = originalImage.exif.exifIfd.orientation!;
    final int height = orientation == 6 || orientation == 8 ? originalImage.width : originalImage.height;
    final int width = orientation == 6 || orientation == 8 ? originalImage.height : originalImage.width;

    const int preferredSize = 1280;
    final Map<String, dynamic> contextualSize = {'orientation' : width >= height ? 'w' : 'h', 'size' : width >= height ? width : height};

    debugPrint("original height : $height");
    debugPrint("original width : $width");
    debugPrint("original orientation : $orientation");

    if(contextualSize['size'] > preferredSize) {

      img.Image fixedImage;

      int compressWidth = contextualSize['orientation'] == 'w' ? preferredSize : (preferredSize.toDouble() * (width.toDouble()/height.toDouble())).round();
      int compressHeight = contextualSize['orientation'] == 'h' ? preferredSize :  (preferredSize.toDouble() *  (height.toDouble()/width.toDouble())).round();

      fixedImage = img.copyResize(originalImage, width: compressWidth, height: compressHeight);

      debugPrint("new height : ${fixedImage.height}");
      debugPrint("new width : ${fixedImage.width}");
        
      // Here you can select whether you'd like to save it as png
      // or jpg with some compression
      // I choose jpg with 100% quality
      final fixedFile = await originalFile.writeAsBytes(img.encodeJpg(fixedImage, quality: 50));

      return fixedFile;

    } else {

      return originalFile;

    }

  }