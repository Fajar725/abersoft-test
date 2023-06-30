import 'package:abersoft_test/const/custom_color.dart';
import 'package:flutter/material.dart';

Widget simpliedButton(String? title, {
  IconData? prefixIcon, 
  Color? iconColor, 
  TextStyle? textStyle, 
  EdgeInsetsGeometry? padding, 
  Color? backgroundColor, 
  double? fixedWidth, 
  double? fixedHeight, 
  double? borderRadius, 
  double? elevation,
  Color? borderColor,
  double? borderWidth, 
  Function()? action
}){

  return ElevatedButton(
    onPressed: action,
    style: ElevatedButton.styleFrom(
      elevation: elevation ?? 0.0,
      fixedSize: Size(fixedWidth ?? double.infinity, fixedHeight ?? 50),
      minimumSize: const Size(0.0, 0.0),
      backgroundColor: backgroundColor ?? Colors.transparent,
      padding: padding ?? const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        side: borderColor != null && borderWidth != null ? BorderSide(color: borderColor, width: borderWidth) : BorderSide.none,
        borderRadius: BorderRadius.circular(borderRadius ?? 10.0)
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    ),
    child: prefixIcon != null 
    ? Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(prefixIcon, color: iconColor ?? textWhite),
        const SizedBox(width: 10),
        Text(
          title!, 
          style: textStyle ?? const TextStyle(
            fontFamily: "Montserrat", 
            fontSize: 16,
            color: logisBlue,
            fontWeight: FontWeight.bold
          )
        )
      ]
    )
    : Text(
      title!, 
      style: textStyle ?? const TextStyle(
        fontFamily: "Montserrat", 
        fontSize: 16,
        color: logisBlue,
        fontWeight: FontWeight.bold
      )
    )
  );
}

// Widget widgetSimpliedButton(Widget widget, {
//   EdgeInsetsGeometry? padding, 
//   Color? backgroundColor, 
//   double? fixedWidth, 
//   double? fixedHeight, 
//   double? borderRadius, 
//   Color? borderColor,
//   double? borderWidth, 
//   Function()? action
// }){
//   MaterialStateProperty<Color?> propColor = MaterialStateProperty.all<Color?>(backgroundColor ?? Colors.white);
//   MaterialStateProperty<Size?> propSize = MaterialStateProperty.all<Size?>(Size(fixedWidth ?? double.infinity, fixedHeight ?? 50));
//   MaterialStateProperty<Size?> propZeroSize = MaterialStateProperty.all<Size?>(const Size(0.0, 0.0));
//   MaterialStateProperty<EdgeInsetsGeometry?> propPadding = MaterialStateProperty.all<EdgeInsetsGeometry?>(padding ?? const EdgeInsets.all(8));
//   MaterialStateProperty<RoundedRectangleBorder?> propBorder = MaterialStateProperty.all<RoundedRectangleBorder?>(
//     RoundedRectangleBorder(
//       side: borderColor != null && borderWidth != null ? BorderSide(color: borderColor, width: borderWidth) : BorderSide.none,
//       borderRadius: BorderRadius.circular(borderRadius ?? 10.0)
//     )
//   );

//   return TextButton(
//     onPressed: action,
//     style: ButtonStyle(
//       fixedSize: propSize,
//       minimumSize: propZeroSize,
//       // maximumSize: propSize,
//       backgroundColor: propColor,
//       padding: propPadding,
//       shape: propBorder
//     ),
//     child: widget
//   );
// }