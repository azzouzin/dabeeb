import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/components/api_handle_ui_widget.dart';
import 'package:getx_skeleton/app/components/custom_text.dart';
import 'package:getx_skeleton/app/components/custom_text_form_field.dart';
import 'package:getx_skeleton/app/routes/routes.dart';
import 'package:getx_skeleton/config/theme/light_theme_colors.dart';

import 'home_controller.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        onPressed: () {
          Get.toNamed(Routes.ADDCLIENT);
        },
      ),
      appBar: AppBar(
        leading: Image.asset("assets/images/app_icon.png"),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: CustomText(
          txt: "Dabeeb Clients",
          color: LightThemeColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (_) {
          return ApiHandleUiWidget(
            successWidget: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 2.0.w),
                        child: CustomTextFormField(
                          hintTxt: "Search",
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                      ...controller.clients
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                              child: InkWell(
                                onTap: () async {
                                  var result = await BarcodeScanner.scan(
                                    options: ScanOptions(),
                                  );
                                  print(result
                                      .type); // The result type (barcode, cancelled, failed)
                                  print(
                                      result.rawContent); // The barcode content
                                  print(result
                                      .format); // The barcode format (as enum)
                                  print(result
                                      .formatNote); // If a unknown format was scanned this field contains a note
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(txt: e.name),
                                    CustomText(txt: e.phone),
                                    CustomText(txt: e.email),
                                    CustomText(txt: e.address),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ]),
              ),
            ),
            apiCallStatus: controller.apiCallStatus,
          );
        },
      ),
    );
  }
}
