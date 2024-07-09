import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:getx_skeleton/app/data/models/client_model.dart';

import '../../../../components/custom_text.dart';
import '../../../../routes/routes.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({super.key, required this.client});
  final ClientModel client;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var result = await BarcodeScanner.scan(
          options: const ScanOptions(),
        );
        print(result.type); // The result type (barcode, cancelled, failed)
        print(result.rawContent); // The barcode content
        print(result.format); // The barcode format (as enum)
        print(result
            .formatNote); // If a unknown format was scanned this field contains a note

        Get.toNamed(Routes.CART);
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
                CustomText(txt: client.mobileId.toString()),
                CustomText(txt: client.email ?? ""),
                CustomText(txt: client.adresse ?? ""),
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
