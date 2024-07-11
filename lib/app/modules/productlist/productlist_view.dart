import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/components/api_handle_ui_widget.dart';
import 'package:getx_skeleton/app/components/custom_snackbar.dart';
import 'package:loadmore/loadmore.dart';

import '../../../config/theme/light_theme_colors.dart';
import '../../components/custom_text.dart';
import '../../components/custom_text_form_field.dart';
import '../../routes/routes.dart';
import './productlist_controller.dart';

class ProductlistView extends GetView<ProductlistController> {
  const ProductlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("assets/images/app_icon.png"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: CustomText(
          txt: "Les lots",
          color: LightThemeColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(25.r),
            bottomRight: Radius.circular(25.r),
            bottomLeft: Radius.circular(25.r),
          ),
        ),
        child: Icon(Icons.qr_code_2_sharp),
        onPressed: () async {
          //controller.getData("");
          var result = await BarcodeScanner.scan(
            options: const ScanOptions(),
          );
          print(result.type); // The result type (barcode, cancelled, failed)
          print(result.rawContent); // The barcode content
          print(result.format); // The barcode format (as enum)
          print(result
              .formatNote); // If a unknown format was scanned this field contains a note

          if (result.rawContent == "") {
            CustomSnackBar.showCustomErrorSnackBar(
                title: "Produit nes pas exist",
                message: "Veuillez scanner un produit existant");
          } else {
            controller.getProductByBarCode(result.rawContent);
          }
        },
      ),
      body: GetBuilder<ProductlistController>(
        builder: (controller) {
          return ApiHandleUiWidget(
            apiCallStatus: controller.apiCallStatus,
            successWidget: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.0.w),
                  child: CustomTextFormField(
                    controller: controller.searchController,
                    hintTxt: "Recherche",
                    prefixIcon: const Icon(Icons.search),
                    onCompleted: () {
                      controller
                          .searchWordChanged(controller.searchController.text);
                    },
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
                                      child: Text(
                                        controller.products[index].product!
                                                .designation
                                                .toString() +
                                            controller
                                                .products[index].product!.id
                                                .toString(),
                                        style: Get.textTheme.labelLarge,
                                      ),
                                    ),
                                    16.horizontalSpace,
                                    Container(
                                      padding: EdgeInsets.all(16.w),
                                      decoration: BoxDecoration(
                                          color: Get.theme.primaryColor
                                              .withOpacity(0.6),
                                          shape: BoxShape.circle),
                                      child: Text(
                                        controller.products[index].product!.qte
                                            .toString(),
                                        style: Get.textTheme.labelLarge,
                                      ),
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
