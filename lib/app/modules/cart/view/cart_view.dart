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
import 'componants/cart_product.dart';
import 'componants/empty_cart.dart';

class CartView extends StatelessWidget {
  CartView({super.key});
  final CartController controller = Get.find();

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: InkWell(
          onTap: () => Get.toNamed(Routes.PRODUCTLIST),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
      title: Text(
        "Le panier",
        style: Theme.of(context).textTheme.displayLarge,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                Get.offAllNamed(Routes.HOME);
              },
              child: const Text(
                "Annulé",
                style: TextStyle(color: Colors.white),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(),
              onPressed: () {
                controller.createOrder();
              },
              child: const Text(
                "validée",
                style: TextStyle(color: Colors.white),
              )),
        ),
      ],
    );
  }

  Widget cartList() {
    return SingleChildScrollView(
      child: Column(children: [
        ...controller.cartProducts.map((product) {
          return CartProductCard(
            controller: controller,
            product: product,
          );
        }).toList(),
        SizedBox(
          height: 100.h,
        )
      ]),
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
                  "${controller.totalPrice.value} DA",
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
          label: ("Validée le panier"),
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
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     controller.getLogo();
      //   },
      //   label: const Text("Ajouter Produit"),
      //   icon: const Icon(Icons.add),
      // ),
      appBar: _appBar(context),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          //  print("Goint BNAck");
          // Get.toNamed(Routes.PRODUCTDETAILS);
        },
        child: GetBuilder<CartController>(builder: (_) {
          return ApiHandleUiWidget(
            apiCallStatus: controller.apiCallStatus,
            successWidget: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: !controller.isEmptyCart
                      ? cartList()
                      : Image(
                          image: MemoryImage(
                              base64Decode(controller.logo.split(',').last))),
                  //const EmptyCart(),
                ),
                bottomBarTitle(),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: CustomButton(
                    label: ("Ajouter Produit"),
                    width: 100.w,
                    color: LightThemeColors.iconColor,
                    high: 75.h,
                    onPressed: () {
                      Get.toNamed(Routes.PRODUCTLIST);
                    },
                  ),
                ),
                //  bottomBarButton()
              ],
            ),
          );
        }),
      ),
    );
  }
}
