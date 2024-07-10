import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getx_skeleton/app/data/models/client_model.dart';

import '../../../../components/custom_text.dart';

class ClientCard extends StatelessWidget {
  const ClientCard({super.key, required this.client});
  final ClientModel client;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {},
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
