// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:fruit_shop/utils/app_drawer.dart';
import 'package:fruit_shop/utils/fruit_card.dart';
import 'package:get/get.dart';

class StockDetailScreen extends StatelessWidget {
  const StockDetailScreen({super.key});
  static String name = "/stock_details_screen";

  @override
  Widget build(BuildContext context) {
    //HomeController homeController = Get.find<HomeController>();
    Map argument = Get.arguments;
    Map data = argument['data'];
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          title: const AppBarTitle(title: "Stock Detail"),
        ),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 1.sw,
            height: 0.4.sh,
            child: Hero(
              transitionOnUserGestures: true,
              tag: argument['tag'],
              child: Image.asset(
                'assets/apple.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: context.padding(),
            child: Column(
              children: [
                Text(
                  "${DateTime.now().toString().substring(0, 10)}(Today)",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                SizedBox(
                  height: 25.h,
                ),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: EdgeInsets.zero,
                  collapsedShape: Border.all(color: Colors.transparent),
                  shape: Border.all(color: Colors.transparent),
                  title: Text(
                    "Today Stock",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  children: [
                    Row(
                      children: [
                        Text(
                          "Quantity",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        const Spacer(),
                        Text("Investment",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey)),
                      ],
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Row(
                      children: [
                        Text(
                          // homeController.fruitDetail.value.stockQuantity
                          //     .toString(),
                          data['stockquantity'].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey),
                        ),
                        const Spacer(),
                        Text(data['investment'].toString(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                cardWid(context, data),
                SizedBox(
                  height: 25.h,
                ),
                indicator(
                  context,
                  "SoldOut",
                  const Color(0xff017403),
                  data['salequantity'].toString(),
                ),
                SizedBox(
                  height: 20.h,
                ),
                indicator(
                  context,
                  "Stocked",
                  Colors.red,
                  data['remainingquantity'].toString(),
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
                      'Rs. ${data['saleprice'].toString()}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          )
        ])));
  }

  Widget cardWid(BuildContext context, Map data) {
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
                duration: const Duration(seconds: 1),
                width: MediaQuery.of(context).size.width *
                    ((data['salequantity'] / data['stockquantity']) * 100) /
                    100,
                height: 25.h,
                decoration: BoxDecoration(
                    color: const Color(0xff017403),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.r),
                        bottomLeft: Radius.circular(8.r))),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget indicator(
      BuildContext context, String title, Color color, String status) {
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
}
