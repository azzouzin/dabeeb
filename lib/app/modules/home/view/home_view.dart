import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/components/api_handle_ui_widget.dart';
import 'package:getx_skeleton/app/components/custom_text.dart';
import 'package:getx_skeleton/app/components/custom_text_form_field.dart';
import 'package:getx_skeleton/app/data/local/shared_pref.dart';
import 'package:getx_skeleton/app/modules/home/view/components/client_card.dart';
import 'package:getx_skeleton/app/routes/routes.dart';
import 'package:getx_skeleton/config/theme/light_theme_colors.dart';
import 'package:loadmore/loadmore.dart';

import '../home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(25.r),
            bottomRight: Radius.circular(25.r),
            bottomLeft: Radius.circular(25.r),
          ),
        ),
        onPressed: () {
          Get.toNamed(Routes.ADDCLIENT);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        leading: Image.asset("assets/images/app_icon.png"),
        actions: [
          IconButton(
            onPressed: () {
              SharedPref.clear();
              Get.offAllNamed(Routes.LOGIN);
            },
            icon: Icon(
              Icons.logout,
              size: 30.h,
              color: LightThemeColors.primaryColor,
            ),
          )
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: CustomText(
          txt: "Clients",
          color: LightThemeColors.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 20.sp,
        ),
      ),
      body: GetBuilder<HomeController>(
        builder: (_) {
          return ApiHandleUiWidget(
            successWidget: SafeArea(
              child: RefreshIndicator(
                onRefresh: () => controller.fetchClients(),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.w, vertical: 2.0.w),
                      child: CustomTextFormField(
                        controller: controller.searchController,
                        hintTxt: "Recherche",
                        prefixIcon: const Icon(Icons.search),
                        onCompleted: () {
                          controller.searchWordChanged(
                              controller.searchController.text);
                        },
                      ),
                    ),
                    Expanded(
                      child: LoadMore(
                        textBuilder: (status) {
                          return status == LoadMoreStatus.loading
                              ? "Loading"
                              : "Complete";
                        },
                        isFinish: controller.isFinished,
                        onLoadMore: () async {
                          await controller.getClients(
                              controller.searchController.text,
                              controller.pageIndicator);
                          return true;
                        },
                        child: ListView.builder(
                          itemCount: controller.clients.length,
                          itemBuilder: (context, index) {
                            return ClientCard(
                                client: controller.clients[index]);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            apiCallStatus: controller.apiCallStatus,
          );
        },
      ),
    );
  }
}
