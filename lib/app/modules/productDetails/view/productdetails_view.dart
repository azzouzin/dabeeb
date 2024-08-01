import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:getx_skeleton/app/components/api_handle_ui_widget.dart';
import 'package:getx_skeleton/app/data/models/product_model.dart';
import 'package:getx_skeleton/app/modules/productDetails/view/zoomimages_view.dart';
import 'package:getx_skeleton/app/modules/productdetails/productdetails_controller.dart';
import 'package:getx_skeleton/config/theme/light_theme_colors.dart';
import '../../../components/custom_button.dart';
import '../../login/login_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  ProductDetailsView({Key? key}) : super(key: key);
  final ProductModel product = Get.arguments["product"];
  final bool isNonEditable = Get.arguments["NonEditableProduct"] ?? false;
  @override
  final ProductDetailsController controller =
      Get.put(ProductDetailsController(), permanent: true);
  final LoginController loginController = Get.find();
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    // controller.qtyController.text = product.quantity.toString();

    final theme = context.theme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text(
          "Détails des produit",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: SafeArea(
        child: GetBuilder<ProductDetailsController>(builder: (_) {
          return ApiHandleUiWidget(
            apiCallStatus: controller.apiCallStatus,
            successWidget: SizedBox(
              height: Get.height - 30.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30.r),
                          bottomRight: Radius.circular(30.r),
                        ),
                        child: CarouselSlider.builder(
                          carouselController: _controller,
                          options: CarouselOptions(
                            //  height: 400.h,
                            aspectRatio: 16 / 9,
                            autoPlay: true,
                            enableInfiniteScroll: true,
                          ),
                          itemCount: controller.image.length,
                          itemBuilder: (BuildContext context, int itemIndex,
                                  int pageViewIndex) =>
                              InkWell(
                            onTap: () => Get.to(ZoomImagesView),
                            child: Container(
                              //  height: 400.h,
                              width: Get.width,
                              child: controller.image.isEmpty
                                  ? Image.asset("assets/images/app_icon.png")
                                  : InkWell(
                                      onTap: () => Get.to(
                                        ZoomImagesView(
                                          image: controller.image[itemIndex],
                                        ),
                                      ),
                                      child: Image.memory(base64Decode(
                                              controller.image[itemIndex]
                                                  .split(',')
                                                  .last))
                                          .animate()
                                          .slideX(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            begin: 1,
                                            curve: Curves.easeInSine,
                                          ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 225.h,
                        left: 10.w,
                        right: 10.w,
                        child: SizedBox(
                          width: Get.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () => _controller.previousPage(),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                ),
                              ),
                              InkWell(
                                onTap: () => _controller.nextPage(),
                                child: const Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            product.product!.designation!,
                            style: theme.textTheme.bodyLarge,
                          ).animate().fade().slideX(
                                duration: const Duration(milliseconds: 300),
                                begin: -1,
                                curve: Curves.easeInSine,
                              ),
                        ),
                        Text(
                          product.product!.code!,
                          style: theme.textTheme.bodyLarge,
                        ).animate().fade().slideX(
                              duration: const Duration(milliseconds: 300),
                              begin: -1,
                              curve: Curves.easeInSine,
                            ),
                      ],
                    ),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: normalPrice(theme),
                  ),
                  20.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      children: [
                        Text(
                          "Quantité",
                          style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ).animate().fade().slideX(
                              duration: const Duration(milliseconds: 300),
                              begin: -1,
                              curve: Curves.easeInSine,
                            ),
                        8.horizontalSpace,
                        GetBuilder<ProductDetailsController>(
                          builder: (_) => Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // FloatingActionButton(onPressed: () {}),
                                isNonEditable
                                    ? Container()
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              LightThemeColors.primaryColor,
                                          shape: const CircleBorder(),
                                          fixedSize: Size(20.w, 20.w),
                                        ),
                                        onPressed: () {
                                          controller.changeQty(-1);
                                        },
                                        child: const Icon(
                                          Icons.remove_circle,
                                          color: Colors.white,
                                          size: 25,
                                        )),

                                Expanded(
                                  child: Container(
                                    //color: Colors.amber,
                                    child: SizedBox(
                                      height: 45.h,
                                      child: TextField(
                                        controller: controller.qtyController,
                                        readOnly: isNonEditable,
                                        obscureText: false,
                                        style: TextStyle(fontSize: 20.sp),
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          controller.qtyController.text = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Qte",
                                          contentPadding:
                                              EdgeInsets.only(bottom: 10.w),
                                          hintStyle: TextStyle(fontSize: 18.sp),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: LightThemeColors
                                                      .primaryColor)),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  width: 2,
                                                  color: LightThemeColors
                                                      .primaryColor)),
                                        ),
                                        // textInputType: TextInputType.number,
                                      ),
                                    ),
                                  ),
                                ),
                                isNonEditable
                                    ? Container()
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              LightThemeColors.primaryColor,
                                          shape: const CircleBorder(),
                                          fixedSize: Size(20.w, 20.w),
                                        ),
                                        onPressed: () {
                                          controller.changeQty(1);
                                        },
                                        child: const Icon(
                                          Icons.add_circle,
                                          color: Colors.white,
                                        )),
                              ],
                            ).animate().fade().slideX(
                                  duration: const Duration(milliseconds: 300),
                                  begin: -1,
                                  curve: Curves.easeInSine,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  product.qteUniteMesure == 1.0
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                          //   padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              GetBuilder<ProductDetailsController>(
                                  builder: (_) {
                                return Text(
                                    "(${product.qteUniteMesure}Pc/colie)");
                              }),
                            ],
                          ),
                        ),
                  10.verticalSpace,
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(controller.descreption,
                            style: theme.textTheme.bodyLarge!
                                .copyWith(fontWeight: FontWeight.w300))
                        .animate()
                        .fade()
                        .slideX(
                          duration: const Duration(milliseconds: 300),
                          begin: -1,
                          curve: Curves.easeInSine,
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: GetBuilder<ProductDetailsController>(
                        builder: (context) {
                      return CustomButton(
                        label: "Ajouter au panier",
                        onPressed: () => controller.onAddToCartPressed(product),
                        width: Get.width * 0.9,
                        high: Get.height * .075,
                        color: LightThemeColors.primaryColor,
                      ).animate().fade().slideY(
                            duration: const Duration(milliseconds: 300),
                            begin: 1,
                            curve: Curves.easeInSine,
                          );
                    }),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget normalPrice(ThemeData theme) {
    return Row(
      children: [
        Text('${product.prixVente} DA', style: theme.textTheme.titleLarge)
            .animate()
            .fade()
            .slideY(
              duration: const Duration(milliseconds: 200),
              begin: 2,
              curve: Curves.easeInSine,
            ),
      ],
    );
  }
}
