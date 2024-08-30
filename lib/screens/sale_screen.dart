// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/constants/app_status.dart';
import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:fruit_shop/utils/app_drawer.dart';
import 'package:fruit_shop/utils/fruit_card.dart';
import 'package:fruit_shop/utils/sales_bottom_sheet.dart';
import 'package:get/get.dart';

class SaleScreen extends StatelessWidget {
  const SaleScreen({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: context.padding(),
        width: 1.sw,
        height: 1.sh,
        child: Obx(() {
          return homeController.stockList.isNotEmpty
              ? GridView.builder(
                  primary: true,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h),
                  itemCount: homeController.stockList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                            isScrollControlled: false,
                            SalesBottomSheet(
                              title: homeController.stockList[index].stockName,
                              homeController: homeController,
                            ),
                            backgroundColor: Colors.white,
                            barrierColor: Colors.grey.withOpacity(0.7),
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(0)));
                      },
                      child: FruitCard(
                        fruitCardModel: homeController.stockList[index],
                      ),
                    );
                  })
              : homeController.status.value != AppStatus.loading
                  ? SizedBox(
                      child: Center(
                        child: Text(
                          "No Stocks",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    )
                  : const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.green,
                        ),
                      ),
                    );
        }));
  }
}
