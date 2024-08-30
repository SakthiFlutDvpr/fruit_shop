// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/class_models/fruit_model.dart';
import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/network_services/sqlite_connectivity.dart';
import 'package:fruit_shop/screens/stock_detail_screen.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:fruit_shop/utils/app_drawer.dart';
import 'package:fruit_shop/utils/fruit_card.dart';
import 'package:get/get.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key, required this.homeController});

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
                    final object = homeController.stockList[index];
                    return GestureDetector(
                      onTap: () async {
                        Map? data;
                        try {
                          data = await homeController.getStockDetail(object);
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                        Get.toNamed(StockDetailScreen.name, arguments: {
                          'data': data ??
                              {
                                'name': object.stockName,
                                'stockquantity': object.stockQuantity,
                                'investment': object.investment,
                                'salequantity': 0.0,
                                'saleprice': 0.0,
                                'remainingquantity': object.stockQuantity
                              },
                          'tag': "tag$index"
                        });
                      },
                      child: Hero(
                        tag: 'tag$index',
                        child: FruitCard(
                          fruitCardModel: object,
                        ),
                        flightShuttleBuilder: (flightContext, animation,
                            flightDirection, fromHeroContext, toHeroContext) {
                          return ScaleTransition(
                            scale: animation.drive(
                              Tween<double>(begin: 0.0, end: 1.0).chain(
                                CurveTween(curve: Curves.easeInOut),
                              ),
                            ),
                            child: toHeroContext.widget,
                          );
                        },
                      ),
                    );
                  })
              : SizedBox(
                  child: Center(
                    child: Text(
                      "No Stocks",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                );
        }));
  }
}
