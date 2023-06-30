import 'package:abersoft_test/const/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerLine({double? height, double? width}) => Shimmer.fromColors(
  baseColor: textLightGrey,
  highlightColor: textWhite,
  child: Container(
    height: height ?? 10,
    width: width ?? 10,
    decoration: BoxDecoration(
      color: textLightGrey,
      borderRadius: BorderRadius.circular(25)
    )
  )
);

Widget aspectRatioShimmerLine({double? aspectRatio, BorderRadiusGeometry? borderRadius}) => Shimmer.fromColors(
  baseColor: textLightGrey,
  highlightColor: textWhite,
  child: Container(
    decoration: BoxDecoration(
      color: textLightGrey,
      borderRadius: borderRadius ?? BorderRadius.circular(25)
    ),
    child: const AspectRatio(aspectRatio: 16/9)
  )
);

