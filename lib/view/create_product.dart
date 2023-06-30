import 'dart:io';

import 'package:abersoft_test/const/custom_button.dart';
import 'package:abersoft_test/const/custom_color.dart';
import 'package:abersoft_test/const/custom_dialog.dart';
import 'package:abersoft_test/const/custom_text_style.dart';
import 'package:abersoft_test/const/image_manipulator.dart';
import 'package:abersoft_test/infra/enum/custom_exception_enum.dart';
import 'package:abersoft_test/model/product_request.dart';
import 'package:abersoft_test/repository/base_repository_interface.dart';
import 'package:abersoft_test/repository/base_repository_mock.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreateProduct extends StatefulWidget {
  const CreateProduct({super.key});

  @override
  State<CreateProduct> createState() => _CreateProductState();
}

class _CreateProductState extends State<CreateProduct> with WidgetsBindingObserver {
  final BaseRepositoryInterface baseRepository = BaseRepositoryMock.init();
  final _formKey = GlobalKey<FormState>();
  bool isOpen = false;
  final ImagePicker _picker = ImagePicker();
  

  String? name = '';
  String? description = '';
  Rxn<File> image = Rxn();

  RxBool imgError = RxBool(false);

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

    super.dispose();
  }

  // API Section
  void authenticate() async {
    try {
      showLoadingDialog();

      // await baseRepository.createProduct(ProductRequest(
      //   productName: name,
      //   productImage: password,
      //   productDecription: description,
      // ));

      Get.back();
      showMessageWidget(
        'SUCCESS_TITLE_MESSAGE'.tr,
        title: 'SUCCESS_TITLE_MESSAGE'.tr,
        action: () => Get.back()
      );

    } on ForbiddenException catch (e){
      Get.back();
      showMessageWidget(
        e.message!,
        title: 'ERROR_TITLE_MESSAGE'.tr,
        action: () => Get.back()
      );
    } on NotAcceptableException catch (e){
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
  Future<void> showChoiceImagePicker() {
    return showWidgetBotomSheet(
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          InkWell(
            onTap: () {
              getImage("CAMERA");
              Navigator.of(context).pop();
            },
            child: Ink(
              child: const Row(
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(width: 20),
                  Text("Gunakan Kamera", style: montserratBold16Black),
                ]
              )
            )
          ),
          const SizedBox(height: 24),
          InkWell(
            onTap: () {
              getImage("GALLERY");
              Navigator.of(context).pop();
            },
            child: Ink(
              child: const Row(
                children: [
                  Icon(Icons.photo),
                  SizedBox(width: 20),
                  Text("Buka Gallery", style: montserratBold16Black),
                ]
              ),
            )
          ),
          const SizedBox(height: 24)
        ]
      )
    );
  }

  // Function Section
  String? nullValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'NULL_MESSAGE'.tr;
    } 

    return null;
  }

  Future getImage(String type) async {

    final pickedFile = await _picker.pickImage(
      source: type == "CAMERA" ? ImageSource.camera : ImageSource.gallery
    );

    if (pickedFile != null) {
      image.value = await rezise(File(pickedFile.path));
    } else {
      debugPrint('No image selected.');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product', style: montserratBold16White),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() {
                var rx = image.value;
                var rxError = imgError.value;

                return AspectRatio(
                  aspectRatio: 16/9,
                  child: InkWell(
                    onTap: () => showChoiceImagePicker(),
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: rxError ? Border.all(color: red, width: 1.5) : null,
                        color: textDarkGrey,
                        image: rx != null ? DecorationImage(
                          image: FileImage(
                            rx
                          ),
                          fit: BoxFit.cover
                        ) : null
                      ),
                      child: rx != null ? const Center(
                        child: Text('Tekan untuk masukkan gambar', style: montserratRegular12Black),
                      ) : const SizedBox(),
                    )
                  ),
                );
              }),
              const SizedBox(height: 20),
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
                  labelText: "Nama",
                  labelStyle: montserratRegular12Grey,
                  floatingLabelStyle: montserratRegular12Blue,
                ),
                validator: nullValidator,
                onSaved: (value) => name = value,
              ),
              const SizedBox(height: 10),
              TextFormField(
                style: montserratRegular12Blue,
                maxLines: 6,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: logisBlue),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Deskripsi",
                  labelStyle: montserratRegular12Grey,
                  floatingLabelStyle: montserratRegular12Blue,
                ),
                validator: nullValidator,
                onSaved: (value) => description = value,
              ),
              const SizedBox(height: 30),
              simpliedButton(
                'SUBMIT'.tr, 
                elevation: 2, 
                backgroundColor: logisBlue, 
                textStyle: montserratBold14White, 
                action: (){
                  if(_formKey.currentState!.validate() && image.value != null){
                    _formKey.currentState!.save();
                    authenticate();
                  } else {
                    imgError.value = true;
                  }
                }
              )
            ]
          )
        )
      )
    );
  }
}