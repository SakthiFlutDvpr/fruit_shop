import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/class_models/fruit_model.dart';
import 'package:fruit_shop/constants/app_status.dart';

import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/screens/image_pick_screen.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:fruit_shop/utils/filled_button.dart';
import 'package:fruit_shop/utils/input_field.dart';
import 'package:get/get.dart';

class AddStockScreen extends StatefulWidget {
  const AddStockScreen({super.key});
  static String name = "/add_stock_screen";

  @override
  State<AddStockScreen> createState() => _AddStockScreenState();
}

class _AddStockScreenState extends State<AddStockScreen> {
  late HomeController homeController;
  final formKey = GlobalKey<FormState>();
  Map? arg = Get.arguments;

  late TextEditingController fruitNameController;
  late TextEditingController fruitQuantityController;
  late TextEditingController fruitInvestingController;

  @override
  void initState() {
    homeController = Get.find<HomeController>();
    fruitNameController =
        TextEditingController(text: arg != null ? arg!['name'] : '');
    fruitQuantityController = TextEditingController();
    fruitInvestingController = TextEditingController();
    homeController.xFile.value = arg != null ? arg!['image'] : '';
    homeController.imgColor.value = Colors.grey;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                        Obx(() {
                          return Container(
                            height: 150.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                image: DecorationImage(
                                    image: homeController.xFile.value.isNotEmpty
                                        ? AssetImage(
                                            homeController.xFile.value,
                                          )
                                        : const AssetImage(
                                            "assets/camera.jpeg"),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle),
                          );
                        }),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(() {
                          return upLoadButton(homeController);
                        })
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
                    controller: fruitNameController,
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
                    controller: fruitQuantityController,
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
                    controller: fruitInvestingController,
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
                      Expanded(child: Obx(() {
                        return UpdateButton(
                          loading:
                              homeController.status.value == AppStatus.loading
                                  ? true
                                  : false,
                          text: "Add Stock",
                          onTap: () async {
                            if (homeController.xFile.isNotEmpty) {
                              if (formKey.currentState!.validate()) {
                                homeController.status.value = AppStatus.loading;
                                try {
                                  FruitModel fruitModel = FruitModel(
                                      stockImage: homeController.xFile.value,
                                      stockName: fruitNameController.text
                                          .toLowerCase(),
                                      stockQuantity: double.parse(
                                          fruitQuantityController.text),
                                      investment: double.parse(
                                          fruitInvestingController.text));

                                  await homeController.addStocks(fruitModel);

                                  await homeController
                                      .addStockHistory(fruitModel);

                                  await homeController.getStocks();
                                } catch (error) {
                                  debugPrint(
                                      '${error.toString()} ???????????????????');
                                }
                                homeController.status.value = AppStatus.success;
                                fruitNameController.clear();
                                fruitQuantityController.clear();
                                fruitInvestingController.clear();
                                homeController.xFile.value = '';
                                Get.back();
                              }
                            } else {
                              homeController.imgColor.value = Colors.red;
                            }
                          },
                          isDisable: false,
                          verticalPadding: 10.h,
                        );
                      })),
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
          Get.toNamed(ImagePickScreen.name);
        },
        style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 0),
            side: BorderSide(width: 1, color: controller.imgColor.value),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r)))),
        child: Text(
          "Pick an Image",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: controller.imgColor.value,
          ),
        ));
  }
}
