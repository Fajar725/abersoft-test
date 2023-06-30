import 'package:abersoft_test/const/custom_button.dart';
import 'package:abersoft_test/const/custom_color.dart';
import 'package:abersoft_test/const/custom_dialog.dart';
import 'package:abersoft_test/const/custom_text_style.dart';
import 'package:abersoft_test/const/custom_widget.dart';
import 'package:abersoft_test/infra/enum/custom_exception_enum.dart';
import 'package:abersoft_test/infra/enum/rest_enum.dart';
import 'package:abersoft_test/model/product.dart';
import 'package:abersoft_test/model/products.dart';
import 'package:abersoft_test/repository/base_repository.dart';
import 'package:abersoft_test/repository/base_repository_interface.dart';
import 'package:abersoft_test/repository/base_repository_mock.dart';
import 'package:abersoft_test/view/create_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final BaseRepositoryInterface baseRepository = BaseRepository.init();

  final Rx<Products> products = Rx(Products());
  final Rx<RestEnum> productRestStatus = Rx(RestEnum.loading);
  String? errorString;

  @override
  void initState() {
    super.initState();

    getProducts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // API Section
  Future<void> getProducts() async {
    try {
      productRestStatus.value = RestEnum.loading;

      Products response = await baseRepository.getProducts();

      productRestStatus.value = RestEnum.success;
      products.value = response;

    } on ForbiddenException {
      Get.back();
      showUnauthorizedDialog();
    } on NotAcceptableException catch(e){
      productRestStatus.value = RestEnum.notAcceptable;
      errorString = e.message;
    } on UnexpectedException catch(e){
      productRestStatus.value = RestEnum.notAcceptable;
      errorString = e.message;
    }
  }

  // Widget Section
  Widget loadingCard() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          aspectRatioShimmerLine(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0))
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: shimmerLine(
              width: 97,
              height: 14,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: shimmerLine(
              width: 124,
              height: 12,
            ),
          )
        ],
      ),
    );
  }

  Widget cardData(Product data) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16/9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0), 
                  bottomRight: Radius.circular(12.0),
                ),
                image: DecorationImage(
                  image: NetworkImage(
                    data.imageUrl ?? ''
                  ),
                  fit: BoxFit.cover
                )
              )
            )
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              data.name ?? '-',
              style: montserratBold14Black,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              data.productDescription ?? '-',
              style: montserratRegular12Black,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          )
        ],
      ),
    );
  }

  // Function Section


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Portofolio', style: montserratBold16White),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: simpliedButton(
          'Create Product',
          backgroundColor: logisBlue,
          elevation: 0,
          textStyle: montserratBold14White,
          action: () async {
            bool isSuccess = await Get.to<bool>(const CreateProduct()) ?? false;

            if (isSuccess) {
              getProducts();
            }

          }
        )
      ),
      body: Obx(() {
        var rx = products.value;
        var rxStatus = productRestStatus.value;

        if(rxStatus == RestEnum.loading) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Text('Best Product', style: montserratBold14Black),
              ),
              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 16.0, right: 4.0),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return AspectRatio(
                      aspectRatio: 16/15,
                      child: Container(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: loadingCard(),
                      )
                    );
                  }
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Text('All Product', style: montserratBold14Black),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 16/15
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return loadingCard();
                  }
                )
              )
            ]
          );
        }

        if(rxStatus == RestEnum.notAcceptable) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, color: red, size: 46),
                Text('ERROR_TITLE_MESSAGE'.tr),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Text('Best Product', style: montserratBold14Black),
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 16.0, right: 4.0),
                scrollDirection: Axis.horizontal,
                itemCount: rx.bestProduct?.length,
                itemBuilder: (context, index) {
                  return AspectRatio(
                    aspectRatio: 16/15, 
                    child: Container(
                      margin: const EdgeInsets.only(right: 12.0),
                      child: cardData(rx.bestProduct![index])
                    )
                  );
                }
              )
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Text('All Product', style: montserratBold14Black),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 16/15
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return cardData(rx.allProduct![index]);
                }
              )
            )
          ]
        );

      })
    );
  }
}