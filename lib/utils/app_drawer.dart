import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/constants/app_status.dart';
import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/network_services/firebase_connectivity.dart';
import 'package:fruit_shop/screens/sales_history.dart';
import 'package:fruit_shop/screens/stock_history.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).colorScheme.secondary.withOpacity(1),
        height: 1.sh,
        width: 0.8.sw,
        child: Column(
          children: [
            SizedBox(
              height: 35.h,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                padding: context.padding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 65.r,
                      backgroundColor: Colors.grey.shade400,
                      child: Image.asset(
                        "assets/fruitshopone.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      "Mohammed Sahil Gafur",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber.shade800),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                    ListTile(
                        onTap: () {
                          Get.toNamed(SalesHistoryScreen.name);
                        },
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "SalesHistory",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: 25.sp,
                        )),
                    const Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                    ListTile(
                        onTap: () {
                          Get.toNamed(StockHistoryScreen.name);
                        },
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "StocksHistory",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          size: 25.sp,
                        )),
                    const Divider(
                      color: Colors.black,
                      thickness: 1.5,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: context.padding(),
              child: Row(
                children: [
                  Expanded(child: Obx(() {
                    return OutlinedButton(
                        onPressed: () async {
                          homeController.status.value = AppStatus.loading;
                          try {
                            //await FireStoreConnection.deletingSales();
                            await homeController.addSalesHistory();
                          } catch (error) {
                            debugPrint(error.toString());
                          }
                          await FireStoreConnection.deletingSales();
                          homeController.status.value = AppStatus.success;
                        },
                        style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            side:
                                const BorderSide(width: 1, color: Colors.black),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)))),
                        child: homeController.status.value != AppStatus.loading
                            ? Text(
                                "End Of Day",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ));
                  })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
