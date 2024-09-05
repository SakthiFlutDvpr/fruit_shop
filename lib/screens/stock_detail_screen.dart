// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/fruit_controller.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/screens/add_stock.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:fruit_shop/utils/app_drawer.dart';
import 'package:fruit_shop/utils/filled_button.dart';
import 'package:fruit_shop/utils/fruit_card.dart';
import 'package:get/get.dart';

class StockDetailScreen extends StatelessWidget {
  const StockDetailScreen({super.key});
  static String name = "/stock_details_screen";

  @override
  Widget build(BuildContext context) {
    FruitController controller = Get.find<FruitController>();

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          title: const AppBarTitle(title: "Stock Detail"),
          actions: [
            IconButton(
                onPressed: () {
                  generateMenu(context, controller);
                },
                icon: const Icon(Icons.more_vert))
          ],
        ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 1.sw,
            height: 0.4.sh,
            child: Hero(
                transitionOnUserGestures: true,
                tag: controller.argument['tag'],
                child: Image(
                    fit: BoxFit.cover,
                    image: FileImage(
                      File(
                        controller.argument['image'],
                      ),
                    ))
                //  Image.asset(
                //   controller.argument['image'],
                //   fit: BoxFit.cover,
                //   errorBuilder: (context, error, stackTrace) => Container(
                //     color: Colors.grey,
                //     child: Text(
                //       "No Image",
                //       style: Theme.of(context).textTheme.bodyMedium,
                //     ),
                //   ),
                // ),
                ),
          ),
          Container(
              padding: context.padding(),
              child: Obx(() {
                return Column(
                  children: [
                    Text(
                      "${controller.argument['data'].toString().capitalize}(Today)",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    cardWid(context, controller),
                    SizedBox(
                      height: 25.h,
                    ),
                    indicator(
                      context,
                      "SoldOut",
                      const Color(0xff017403),
                      controller.sold.value.toString(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    indicator(
                      context,
                      "Stocked",
                      Colors.red,
                      controller.stocked.value.toString(),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.money,
                          size: 25.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "SalePrice",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Spacer(),
                        Text(
                          'Rs. ${controller.earning.value.toString()}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ],
                );
              })),
        ])));
  }

  Widget cardWid(BuildContext context, FruitController controller) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 25.h,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8.r)),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 800),
                  width: MediaQuery.of(context).size.width *
                      ((controller.sold.value + controller.stocked.value) > 0
                          ? (controller.sold.value /
                              (controller.sold.value +
                                  controller.stocked.value))
                          : 0),
                  height: 25.h,
                  decoration: BoxDecoration(
                      color: const Color(0xff017403),
                      borderRadius: BorderRadius.circular(8.r)),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget indicator(
    BuildContext context,
    String title,
    Color color,
    String status,
  ) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 10.w),
          width: 20.w,
          height: 20.h,
          color: color,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const Spacer(),
        Text(
          "$status kg",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  void generateMenu(BuildContext context, FruitController controller) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(1, 80.h, 0, 0),
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        elevation: 3,
        menuPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.h),
        popUpAnimationStyle: AnimationStyle(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
            reverseDuration: const Duration(milliseconds: 100)),
        items: [
          PopupMenuItem(
              padding: context.horizontalPadding(),
              onTap: () async {
                try {
                  controller.getStockDetail(controller.argument['data']);
                } catch (error) {
                  debugPrint(error.toString());
                }
              },
              child: Text("refresh",
                  style: Theme.of(context).textTheme.bodyMedium!)),
          PopupMenuItem(
              padding: context.horizontalPadding(),
              onTap: () async {
                Get.toNamed(AddStockScreen.name, arguments: {
                  'name': controller.argument['data'],
                  'image': controller.argument['image']
                });
              },
              child: Text("Update Stock",
                  style: Theme.of(context).textTheme.bodyMedium!)),
        ]);
  }
}
