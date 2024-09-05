import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/constants/app_status.dart';
import 'package:fruit_shop/controllers/home_controller.dart';

import 'package:fruit_shop/screens/stock_detail_screen.dart';
import 'package:fruit_shop/utils/fruit_card.dart';
import 'package:get/get.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key, required this.homeController});

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        width: 1.sw,
        height: 1.sh,
        child: Obx(() {
          return homeController.stockList.isNotEmpty &&
                  homeController.status.value == AppStatus.success
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
                        Get.toNamed(StockDetailScreen.name, arguments: {
                          'data': object.stockName,
                          'tag': "tag$index",
                          'image': object.stockImage
                        });
                      },
                      onLongPress: () {
                        onLongPressed(context, object.stockName);
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
              : homeController.stockList.isEmpty &&
                      homeController.status.value == AppStatus.success
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

  void onLongPressed(BuildContext context, String stock) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            insetAnimationDuration: const Duration(milliseconds: 2000),
            insetAnimationCurve: Curves.decelerate,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  title: Text(
                    "Remove '${stock.toString().capitalize.toString()}' from Stocks?",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(color: Colors.black),
                  ),
                  backgroundColor: Colors.white,
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                        ),
                        child: Text(
                          "Cancel",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.activeBlue),
                        )),
                    Obx(() {
                      return TextButton(
                          onPressed: () async {
                            homeController.status.value = AppStatus.loading;
                            try {
                              await homeController.deleteSelectedStock(stock);
                            } catch (error) {
                              debugPrint(error.toString());
                            }

                            Get.back();
                            homeController.status.value = AppStatus.success;
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent,
                          ),
                          child: homeController.status.value !=
                                  AppStatus.loading
                              ? Text(
                                  "Remove",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .tertiary),
                                )
                              : Center(
                                  child: CircularProgressIndicator(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                  ),
                                ));
                    })
                  ],
                ),
              ],
            ),
          );
        });
  }
}
