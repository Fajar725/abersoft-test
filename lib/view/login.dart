import 'package:abersoft_test/const/custom_button.dart';
import 'package:abersoft_test/const/custom_color.dart';
import 'package:abersoft_test/const/custom_dialog.dart';
import 'package:abersoft_test/const/custom_text_style.dart';
import 'package:abersoft_test/infra/enum/custom_exception_enum.dart';
import 'package:abersoft_test/model/login_request.dart';
import 'package:abersoft_test/repository/base_repository.dart';
import 'package:abersoft_test/repository/base_repository_interface.dart';
import 'package:abersoft_test/repository/base_repository_mock.dart';
import 'package:abersoft_test/view/products_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  final BaseRepositoryInterface baseRepository = BaseRepository.init();
  bool isOpen = false;
  final _formKey = GlobalKey<FormState>();

  String? username = '';
  String? password = '';

  final RxBool isObscure = RxBool(true);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();

    final value = View.of(context).viewInsets.bottom;
    if(value != 0 && !isOpen) {
      isOpen = true;
    }

    if (value == 0 && isOpen) {
      isOpen = false;
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // API Section
  void authenticate() async {
    try {
      showLoadingDialog();

      await baseRepository.login(LoginRequest(
        username: username,
        password: password
      ));

      Get.back();
      Get.off(const ProductView());

    } on ForbiddenException catch (e){
      Get.back();
      showMessageWidget(
        e.message!,
        title: 'ERROR_TITLE_MESSAGE'.tr,
        action: () => Get.back()
      );
    } on UnexpectedException catch (e){
      Get.back();
      showMessageWidget(
        e.message!,
        title: 'ERROR_TITLE_MESSAGE'.tr,
        action: () => Get.back()
      );
    }
  }

  // Widget Section

  // Function Section
  String? nullValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'NULL_MESSAGE'.tr;
    } 

    return null;
  }

  void obscure() {
    isObscure.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                // margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 55),
                child: Image.asset(
                  "assets/images/logo-blue.png",
                  fit: BoxFit.contain
                )
              )
            ),
            Flexible(
              flex: 3,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      style: montserratRegular12Blue,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: logisBlue),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "username",
                        labelStyle: montserratRegular12Grey,
                        floatingLabelStyle: montserratRegular12Blue,
                      ),
                      validator: nullValidator,
                      onSaved: (value) => username = value,
                    ),
                    const SizedBox(height: 5),
                    Obx(() {
                      var rx = isObscure.value;

                      return TextFormField(
                        style: montserratRegular12Blue,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: logisBlue),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: "password",
                          labelStyle: montserratRegular12Grey,
                          floatingLabelStyle: montserratRegular12Blue,
                          suffixIcon: InkWell(
                            onTap: obscure,
                            child: rx ? const Icon(Icons.visibility_outlined, color: textDarkGrey) 
                              : const Icon(Icons.visibility_off_outlined, color: textDarkGrey)
                          )
                        ),
                        validator: nullValidator,
                        onSaved: (value) => password = value,
                        obscureText: isObscure.value,
                      );
                    }),
                    const SizedBox(height: 30),
                    simpliedButton(
                      'LOGIN'.tr, 
                      elevation: 2, 
                      backgroundColor: logisBlue, 
                      textStyle: montserratBold14White, 
                      action: (){
                        if(_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          authenticate();
                        }
                      }
                    )
                  ]
                )
              )
            )
          ]
        )
      )
    );
  }
}