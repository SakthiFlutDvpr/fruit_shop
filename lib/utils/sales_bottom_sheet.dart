import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/class_models/sale_model.dart';
import 'package:fruit_shop/constants/app_status.dart';
import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/home_controller.dart';

import 'package:fruit_shop/utils/filled_button.dart';
import 'package:fruit_shop/utils/input_field.dart';
import 'package:get/get.dart';

class SalesBottomSheet extends StatelessWidget {
  SalesBottomSheet(
      {super.key,
      required this.title,
      required this.homeController,
      required this.quant});
  final String title;

  final HomeController homeController;
  final double quant;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController saleQuantityController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: context.padding(),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 0.4.sw,
                      height: 1.h,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      title.capitalize.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              labelName("Quantity", context),
              SizedBox(
                height: 10.h,
              ),
              InputField(
                controller: saleQuantityController,
                inputType: TextInputType.number,
                hintText: "E.g. 1kg",
                border: true,
                filled: false,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Quantity Missing";
                  } else if (double.parse(value.toString()) > quant) {
                    return "insufficient quntity";
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              SizedBox(
                height: 20.h,
              ),
              labelName("Price", context),
              SizedBox(
                height: 10.h,
              ),
              InputField(
                controller: salePriceController,
                inputType: TextInputType.number,
                hintText: "E.g. Rs.100",
                border: true,
                filled: false,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Price Missing";
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
                      loading: homeController.status.value == AppStatus.loading
                          ? true
                          : false,
                      text: "Update",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          homeController.status.value = AppStatus.loading;
                          SaleModel saleModel = SaleModel(
                              name: title,
                              quantity:
                                  double.parse(saleQuantityController.text),
                              price: double.parse(salePriceController.text));
                          try {
                            debugPrint(">>>>>>>>>>>> sales entry");

                            await homeController.updateSales(saleModel);
                            debugPrint(">>>>>>>>>>>> sales entry");
                          } catch (error) {
                            debugPrint(error.toString());
                          }
                          homeController.status.value = AppStatus.success;
                          saleQuantityController.clear();
                          salePriceController.clear();
                          Get.back();
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
    );
  }

  Text labelName(String text, BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(color: Colors.black.withOpacity(0.7)),
    );
  }
}
