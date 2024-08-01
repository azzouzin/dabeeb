import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/components/api_handle_ui_widget.dart';
import 'package:getx_skeleton/app/components/custom_snackbar.dart';
import 'package:getx_skeleton/app/modules/cart/cart_controller.dart';
import 'package:loadmore/loadmore.dart';

import '../../../config/theme/light_theme_colors.dart';
import '../../components/custom_text.dart';
import '../../components/custom_text_form_field.dart';
import '../../routes/routes.dart';
import './productlist_controller.dart';

class ProductlistView extends GetView<ProductlistController> {
  ProductlistView({super.key});
  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/images/app_icon.png"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: CustomText(
          txt: "Produits",
          color: LightThemeColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          isExtended: true,
          label: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined),
              Text("${cartController.cartProducts.length} Produits"),
            ],
          ),
          onPressed: () {
            Get.toNamed(Routes.CART);
          }),
      body: GetBuilder<ProductlistController>(
        builder: (controller) {
          return ApiHandleUiWidget(
            apiCallStatus: controller.apiCallStatus,
            successWidget: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.0.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: controller.searchController,
                          hintTxt: "Recherche",
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () => controller.clearSearch(),
                          ),
                          onChange: (s) {
                            controller.searchWordChanged(
                                controller.searchController.text);
                          },
                          onCompleted: () {
                            controller.searchWordChanged(
                                controller.searchController.text);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20.0.h, left: 8.w),
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(shape: CircleBorder()),
                          child: Icon(
                            Icons.qr_code_2_sharp,
                            color: Colors.white,
                            size: 32.h,
                          ),
                          onPressed: () async {
                            //controller.getData("");
                            var result = await BarcodeScanner.scan(
                              options: const ScanOptions(),
                            );

                            print(result.rawContent); // The barcode content

                            if (result.rawContent == "") {
                              CustomSnackBar.showCustomErrorSnackBar(
                                  title: "Produit inexistant",
                                  message:
                                      "Veuillez scanner un produit existant");
                            } else {
                              controller.getProductByBarCode(result.rawContent);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: LoadMore(
                    textBuilder: (status) {
                      return status == LoadMoreStatus.loading
                          ? "Loading"
                          : "Complete";
                    },
                    isFinish: controller.isFinished,
                    onLoadMore: () async {
                      controller.getData(
                        controller.searchController.text,
                      );
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => controller
                              .onProductTapped(controller.products[index]),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(thickness: 1, color: Colors.grey),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${controller.products[index].product!.code}\n${controller.products[index].product!.designation}",
                                            style: Get.textTheme.labelLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          controller.products[index].prixVente
                                                  .toString() +
                                              " DA",
                                          style: Get.textTheme.labelLarge!
                                              .copyWith(color: Colors.red),
                                        ),
                                        Text(
                                          controller
                                              .products[index].product!.qte
                                              .toString(),
                                          style: Get.textTheme.labelLarge!
                                              .copyWith(
                                                  color:
                                                      Get.theme.primaryColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
