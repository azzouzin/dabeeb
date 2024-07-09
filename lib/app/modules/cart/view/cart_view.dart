import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:getx_skeleton/config/theme/light_theme_colors.dart';

import '../../../../config/products_controller.dart';
import '../../../components/animation_switcher_wrapper.dart';
import '../../../components/custom_button.dart';
import 'componants/empty_cart.dart';

final ProductController controller = Get.put(ProductController());

class CartView extends StatelessWidget {
  const CartView({super.key});

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        "My cart",
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  Widget cartList() {
    return SingleChildScrollView(
      child: Column(
        children: controller.allProducts.map((product) {
          product.textEditingController.text = product.prixVente.toString();
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey[200]?.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: LightThemeColors.accentColor,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.network(
                          "https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1500w,f_auto,q_auto:best/newscms/2021_07/3451045/210218-product-of-the-year-2x1-cs.jpg",
                          width: 100,
                          height: 90,
                        ),
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.product!.designation ?? "Desgniation",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: product.textEditingController,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 23,
                            ),
                            //   decoration: InputDecoration(),
                          ),
                        ),
                        15.horizontalSpace,
                        Container(
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
                              GetBuilder<ProductController>(
                                builder: (ProductController controller) {
                                  return AnimatedSwitcherWrapper(
                                    child: Text(
                                      '${product.quantity}',
                                      key: ValueKey<int>(
                                        product.quantity!,
                                      ),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  );
                                },
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
                        )

                        // Text(
                        //   "DZD",
                        //   style: const TextStyle(
                        //     fontWeight: FontWeight.w900,
                        //     fontSize: 23,
                        //   ),
                        // ),
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
                  key: ValueKey<int>(controller.totalPrice.value),
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
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
        child: CustomButton(
          label: ("Buy now"),
          width: 100.w,
          color: LightThemeColors.primaryColor,
          high: 75.h,
          onPressed: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.getCartItems();
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: !controller.isEmptyCart ? cartList() : const EmptyCart(),
          ),
          bottomBarTitle(),
          bottomBarButton()
        ],
      ),
    );
  }
}
