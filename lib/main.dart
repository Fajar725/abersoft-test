import 'package:abersoft_test/const/strings.dart';
import 'package:abersoft_test/view/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const Login()),
      ],
      builder: (context, child) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, child!),
        minWidth: 390,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(390, name: MOBILE),
          ResponsiveBreakpoint.resize(768, name: TABLET),
          ResponsiveBreakpoint.resize(1024, name: DESKTOP),
        ]
      ),
      title: 'Abersoft Test',
      locale: const Locale('id', 'ID'),
      fallbackLocale: const Locale('en', 'US'),
      translationsKeys: Strings().keys,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      )
    );
  }
}
