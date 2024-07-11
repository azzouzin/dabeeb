import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getx_skeleton/app/components/api_handle_ui_widget.dart';
import 'package:getx_skeleton/app/modules/cart/cart_controller.dart';
import 'package:getx_skeleton/config/theme/light_theme_colors.dart';

import '../../../components/animation_switcher_wrapper.dart';
import '../../../components/custom_button.dart';
import '../../../routes/routes.dart';
import 'componants/empty_cart.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  final CartController controller = Get.find();

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: InkWell(
          onTap: () => Get.back(),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.black)),
      title: Text(
        "My cart",
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  Widget cartList() {
    return SingleChildScrollView(
      child: Column(
        children: controller.cartProducts.map((product) {
          return Container(
            width: double.infinity,
            margin: EdgeInsets.all(8.w),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.grey[200]?.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Get.toNamed(
                        Routes.PRODUCTDETAILS,
                        arguments: {
                          "product": product,
                          "NonEditableProduct": true
                        },
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: LightThemeColors.accentColor,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.r)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: product.images.isEmpty
                                  ? Icon(Icons.info_outline_rounded)
                                  : SizedBox(
                                      width: 75.w,
                                      child: Image.memory(
                                        base64Decode(
                                          product.images.first.split(',').last,
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: Text(
                        product.product!.designation ?? "Desgniation",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () => controller.removeProduct(product),
                        child:
                            Icon(Icons.delete, color: Colors.red, size: 20.sp)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: product.priceController,
                            onEditingComplete: () =>
                                controller.calculateTotalPrice(),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 23,
                            ),
                            //   decoration: InputDecoration(),
                          ),
                        ),
                        15.horizontalSpace,
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  splashRadius: 10.0,
                                  onPressed: () =>
                                      controller.decreaseItemQuantity(product),
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Color(0xFFEC6813),
                                  ),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: product.qtyController,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) => controller.changeQty(
                                        value, product.id!),
                                  ),
                                ),
                                IconButton(
                                  splashRadius: 10.0,
                                  onPressed: () =>
                                      controller.increaseItemQuantity(product),
                                  icon: const Icon(Icons.add,
                                      color: Color(0xFFEC6813)),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget bottomBarTitle() {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Total",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
          ),
          Obx(
            () {
              return AnimatedSwitcherWrapper(
                child: Text(
                  "\$${controller.totalPrice.value}",
                  key: ValueKey<double>(controller.totalPrice.value),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFEC6813),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget bottomBarButton() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: CustomButton(
          label: ("Buy now"),
          width: 100.w,
          color: LightThemeColors.primaryColor,
          high: 75.h,
          onPressed: () {
            controller.createOrder();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(bottom: 100.h),
      //   child: FloatingActionButton(
      //     backgroundColor: LightThemeColors.primaryColor,
      //     onPressed: () => Get.toNamed(Routes.PRODUCTDETAILS),
      //     child: const Icon(Icons.add),
      //   ),
      // ),
      body: GetBuilder<CartController>(builder: (_) {
        return ApiHandleUiWidget(
          apiCallStatus: controller.apiCallStatus,
          successWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: !controller.isEmptyCart ? cartList() : const EmptyCart(),
              ),
              bottomBarTitle(),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: CustomButton(
                  label: ("Ajoute Produit"),
                  width: 100.w,
                  color: LightThemeColors.iconColor,
                  high: 75.h,
                  onPressed: () {
                    Get.toNamed(Routes.PRODUCTLIST);
                  },
                ),
              ),
              bottomBarButton()
            ],
          ),
        );
      }),
    );
  }
  
}
