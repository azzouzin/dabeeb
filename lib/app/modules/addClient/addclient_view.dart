import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/components/custom_button.dart';
import 'package:getx_skeleton/config/theme/light_theme_colors.dart';

import '../../components/custom_text_form_field.dart';
import './addclient_controller.dart';

class AddClientView extends GetView<AddClientController> {
  const AddClientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Client'),
      ),
      body: GetBuilder<AddClientController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              children: [
                CustomTextFormField(
                  label: "Client Name",
                
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        label: ("Cancel"),
                        width: 100.w,
                        color: const Color(0xFFF77D8E),
                        high: 75.h,
                        onPressed: () {},
                      ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: CustomButton(
                        label: ("OK"),
                        width: 100.w,
                        color: const Color.fromARGB(255, 51, 150, 231),
                        //   color: const Color.fromARGB(255, 51, 150, 231),
                        high: 75.h,
                        onPressed: () {},
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
