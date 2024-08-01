import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/components/custom_button.dart';
import 'package:getx_skeleton/app/data/models/price_category_model.dart';
import 'package:getx_skeleton/config/theme/light_theme_colors.dart';

import '../../components/custom_text.dart';
import '../../components/custom_text_form_field.dart';
import './addclient_controller.dart';

class AddClientView extends GetView<AddClientController> {
  AddClientView({super.key});

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter client'),
      ),
      body: GetBuilder<AddClientController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  label: "Nom client",
                  controller: nameController,
                ),
                15.verticalSpace,
                CustomTextFormField(
                  label: "Adresse client",
                  controller: addressController,
                ),
                16.verticalSpace,
                CustomText(
                  txt: "Catégorie",
                  fontSize: 16.sp,
                  color: LightThemeColors.primaryColor,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.bold,
                ),
                8.verticalSpace,
                dropDown(),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        label: ("Annuler"),
                        width: 100.w,
                        color: const Color(0xFFF77D8E),
                        high: 75.h,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    16.horizontalSpace,
                    Expanded(
                      child: CustomButton(
                        label: ("valider"),
                        width: 100.w,
                        color: const Color.fromARGB(255, 51, 150, 231),
                        //   color: const Color.fromARGB(255, 51, 150, 231),
                        high: 75.h,
                        onPressed: () {
                          controller.addClient(
                            nameController.text,
                            addressController.text,
                            controller.selectedPriceCategory!.number ?? 1,
                          );
                        },
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

  Widget dropDown() {
    return SizedBox(
      width: Get.width,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<PriceModel>(
          isExpanded: true,
          hint: Row(
            children: [
              const Icon(
                Icons.list,
                size: 16,
                color: LightThemeColors.accentColor,
              ),
              SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Choisir une catégorie ...',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: LightThemeColors.accentColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: controller.pricesCatorgies
              .map((PriceModel item) => DropdownMenuItem<PriceModel>(
                    value: item,
                    child: Text(
                      item.name ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: controller.selectedPriceCategory,
          onChanged: (PriceModel? value) {
            controller.changeValue(value!);
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(25),
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25),
              ),
              border: Border.all(color: LightThemeColors.accentColor),
              color: LightThemeColors.primaryColor,
            ),
            elevation: 0,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: LightThemeColors.accentColor,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200.h,
            width: Get.width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              color: LightThemeColors.primaryColor,
            ),
            offset: const Offset(0, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: Radius.circular(40.r),
              thickness: MaterialStateProperty.all<double>(6.w),
              thumbVisibility: MaterialStateProperty.all<bool>(true),
            ),
          ),
          menuItemStyleData: MenuItemStyleData(
            height: 40.h,
            padding: EdgeInsets.only(left: 14.w, right: 14.w),
          ),
        ),
      ),
    );
  }
}
