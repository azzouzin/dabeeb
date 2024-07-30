import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/data/models/client_model.dart';
import 'package:getx_skeleton/app/modules/cart/cart_controller.dart';

import '../../../../components/custom_text.dart';
import '../../../../routes/routes.dart';

class ClientCard extends StatelessWidget {
  ClientCard({super.key, required this.client});
  final ClientModel client;
  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        cartController.setClient(client);
        Get.toNamed(Routes.PRODUCTLIST);
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(txt: client.societe ?? ""),
                CustomText(txt: client.wilaya.toString()),
                //CustomText(txt: client.email ?? ""),
                //  CustomText(txt: client.adresse ?? ""),
              ],
            ),
          ),
          const Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
