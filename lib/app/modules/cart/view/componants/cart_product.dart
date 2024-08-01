import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../config/theme/light_theme_colors.dart';
import '../../../../../utils/formatters.dart';
import '../../../../data/models/product_model.dart';
import '../../../../routes/routes.dart';
import '../../cart_controller.dart';

class CartProductCard extends StatelessWidget {
  CartProductCard({super.key, required this.controller, required this.product});

  final CartController controller;
  final ProductModel product; // = controller;

  @override
  Widget build(BuildContext context) {
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
                onTap: () => Get.toNamed(Routes.PRODUCTDETAILS,
                    arguments: {"product": product}),
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
                            ? const Icon(Icons.info_outline_rounded)
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
                  child: Icon(Icons.delete, color: Colors.red, size: 20.sp)),
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
                      onEditingComplete: () => controller.calculateTotalPrice(),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2)
                      ],
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 23.sp,
                      ),
                      decoration: const InputDecoration(
                        suffixIcon: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("DA"),
                          ],
                        ),
                      ),
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
                              onEditingComplete: () => controller.changeQty(
                                  product.qtyController!.text, product.id!),
                            ),
                          ),
                          IconButton(
                            splashRadius: 10.0,
                            onPressed: () =>
                                controller.increaseItemQuantity(product),
                            icon:
                                const Icon(Icons.add, color: Color(0xFFEC6813)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              product.qteUniteMesure == 1.0
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 8.h,
                      ),
                      //   padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "${double.parse(product.qtyController!.text) * (product.qteUniteMesure ?? 1)} Pc (${product.qteUniteMesure}Pc/colie)"),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
