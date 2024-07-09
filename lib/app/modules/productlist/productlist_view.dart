import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/components/api_handle_ui_widget.dart';
import 'package:loadmore/loadmore.dart';

import '../../components/custom_text_form_field.dart';
import './productlist_controller.dart';

class ProductlistView extends GetView<ProductlistController> {
  const ProductlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        controller.getData("");
      }),
      body: GetBuilder<ProductlistController>(
        builder: (controller) {
          return ApiHandleUiWidget(
            apiCallStatus: controller.apiCallStatus,
            successWidget: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 2.0.w),
                  child: CustomTextFormField(
                    controller: controller.searchController,
                    hintTxt: "Search",
                    prefixIcon: const Icon(Icons.search),
                    onCompleted: () {
                      controller
                          .searchWordChanged(controller.searchController.text);
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
                      controller.getData(
                        controller.searchController.text,
                      );
                      return true;
                    },
                    child: ListView.builder(
                      itemCount: controller.products.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => controller
                              .onProductTapped(controller.products[index]),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Divider(thickness: 1, color: Colors.grey),
                                Text(
                                  controller
                                      .products[index].product!.designation
                                      .toString(),
                                  style: Get.textTheme.labelLarge,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
