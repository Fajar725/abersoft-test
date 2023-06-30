import 'package:abersoft_test/const/custom_button.dart';
import 'package:abersoft_test/const/custom_color.dart';
import 'package:abersoft_test/const/custom_text_style.dart';
import 'package:abersoft_test/repository/base_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showLoadingDialog() async {

  return showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (container) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              width: Get.width *  0.575,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: textWhite,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("LOADING_TEXT".tr, style: montserratBold18Black),
                  const SizedBox(height: 40),
                  const CircularProgressIndicator(
                    color: logisBlue,
                  )
                ]
              )
            )
          )
        )
      );
    }
  );

}

Future<void> showUnauthorizedDialog() async {

  return showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (container) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        body: WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              width: Get.width * 0.725,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: textWhite,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('UNAUTHORIZE_MESSAGE'.tr, style: montserratBold18Black),
                  const SizedBox(height: 20),
                  Text('UNAUTHORIZE_DESC'.tr, style: montserratRegular14Black),
                  const SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: simpliedButton(
                      "OK",
                      backgroundColor: logisBlue,
                      textStyle: montserratBold14White,
                      fixedWidth: 240,
                      action: () {
                        BaseRepository.init().logout();
                        Get.offAllNamed('/login');
                      }
                    )
                  )  
                ]
              )
            )
          )
        )
      );
    }
  );

}

Future<dynamic> showMessageWidget(String message, {String? title, Function()? action}) {

  return showModalBottomSheet(
    context: Get.context!, 
    isScrollControlled: true,
    enableDrag: false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    ),
    builder: (container) {
      return Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: Get.context!.mediaQuery.viewInsets.bottom
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            title != null ? Text(title, style: montserratBold18Black, textAlign: TextAlign.center) : const SizedBox(),
            // const SizedBox(height: 50),
            // assets != null ? assets : SvgPicture.asset("assets/images/ilustrasi-sukses.svg", height: 175),
            const SizedBox(height: 30),
            Text(message, style: montserratRegular12Grey, textAlign: TextAlign.center),
            const SizedBox(height: 50),
            simpliedButton(
              "OK",
              elevation: 2.0,
              backgroundColor: logisBlue,
              textStyle: montserratBold14White,
              action: () => Get.back()
            ),
            const SizedBox(height: 50)
          ]
        ),
      );
    }
  ).then((value) {
    if(action != null) {
      action();
    }
  });

}

Future<dynamic> showWidgetBotomSheet(Widget widget, {bool? closeByDrag, double? topPadding, leftPading, rightPadding, bottomPadding}) {

  return showModalBottomSheet(
    context: Get.context!, 
    isScrollControlled: true,
    enableDrag: closeByDrag ?? false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    ),
    builder: (container) {
      return Padding(
        padding: EdgeInsets.only(
          top: topPadding ?? 20,
          left: leftPading ?? 16,
          right: rightPadding ?? 16,
          bottom: Get.context!.mediaQueryViewInsets.bottom + (bottomPadding ?? 20)
        ),
        child: widget
      );
    }
  );
}