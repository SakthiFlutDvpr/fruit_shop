import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/class_models/fruit_model.dart';

import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:fruit_shop/utils/filled_button.dart';
import 'package:fruit_shop/utils/input_field.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddStockScreen extends StatelessWidget {
  AddStockScreen({super.key});
  static String name = "/add_stock_screen";

  final formKey = GlobalKey<FormState>();

  final FocusNode focusNode = FocusNode();

  final ImagePicker imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          title: const AppBarTitle(title: "Add Stock")),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          padding: context.padding(),
          width: 1.sw,
          height: 1.sh,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 1.sw,
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        homeController.xFile != null
                            ? SizedBox(
                                width: 150.w,
                                height: 125.h,
                                child: Image.file(
                                  File(homeController.xFile!.path),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : CircleAvatar(
                                radius: 85.r,
                                backgroundColor: Colors.grey.shade400,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 75.sp,
                                )),
                        SizedBox(
                          height: 10.h,
                        ),
                        upLoadButton(homeController),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  labelName("Stock Name", context),
                  SizedBox(
                    height: 15.h,
                  ),
                  InputField(
                    controller: homeController.fruitNameController,
                    inputType: TextInputType.name,
                    hintText: "E.g. Apple",
                    border: true,
                    filled: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Name Missing";
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  labelName("Stock Quantity", context),
                  SizedBox(
                    height: 15.h,
                  ),
                  InputField(
                    controller: homeController.fruitQuantityController,
                    inputType: TextInputType.number,
                    hintText: "E.g. 100kg",
                    border: true,
                    filled: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Quantity Missing";
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  labelName("Stock Investment", context),
                  SizedBox(
                    height: 15.h,
                  ),
                  InputField(
                    controller: homeController.fruitInvestingController,
                    inputType: TextInputType.number,
                    hintText: "E.g. Rs.1000",
                    border: true,
                    filled: false,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "Investment Missing";
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: UpdateButton(
                          text: "Update",
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                FruitModel fruitModel = FruitModel(
                                    stockName:
                                        homeController.fruitNameController.text,
                                    stockQuantity: double.parse(homeController
                                        .fruitQuantityController.text),
                                    investment: double.parse(homeController
                                        .fruitInvestingController.text));

                                debugPrint(
                                    "object created success >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

                                await homeController.addStocks(fruitModel);

                                await homeController
                                    .addStockHistory(fruitModel);
                                debugPrint(
                                    "stock addedd success >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
                              } catch (error) {
                                debugPrint(
                                    '${error.toString()} ????????????????????????????????????????????');
                              }

                              homeController.fruitNameController.clear();
                              homeController.fruitQuantityController.clear();
                              homeController.fruitInvestingController.clear();
                              Get.back();
                            }
                          },
                          isDisable: false,
                          verticalPadding: 10.h,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget labelName(String text, BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.black.withOpacity(0.7)),
    );
  }

  Widget upLoadButton(HomeController controller) {
    return OutlinedButton(
        onPressed: () async {
          // ImagePicker imagePicker = ImagePicker();

          // XFile? image =
          //     await imagePicker.pickImage(source: ImageSource.gallery);

          // if (image != null) {
          //   controller.xFile = image;
          //   debugPrint(image.path.toString());
          // }

          // debugPrint("image has not been picked");
        },
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
            side: const BorderSide(width: 1, color: Colors.grey),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)))),
        child: Text(
          "Upload From Gallery",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ));
  }
}
