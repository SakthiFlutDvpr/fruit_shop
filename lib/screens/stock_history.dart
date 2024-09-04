import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/constants/app_status.dart';

import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/stock_controller.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:fruit_shop/utils/history_tile.dart';
import 'package:get/get.dart';

class StockHistoryScreen extends StatelessWidget {
  const StockHistoryScreen({super.key});
  static String name = "/stock_history";

  @override
  Widget build(BuildContext context) {
    StockController controller = Get.find<StockController>();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const AppBarTitle(title: "Stock History"),
        actions: [
          IconButton(
              onPressed: () {
                generateMenu(context, controller);
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
              padding: context.padding(),
              width: 1.sw,
              height: 1.sh,
              child: Obx(() {
                return controller.stockHistory.isNotEmpty &&
                        controller.status.value == AppStatus.success
                    ? ListView.separated(
                        itemBuilder: (context, index) {
                          return StockHistoryTile(
                              history: controller.stockHistory[index]);
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 1.5,
                            color: Colors.grey,
                          );
                        },
                        itemCount: controller.stockHistory.length)
                    : controller.stockHistory.isEmpty &&
                            controller.status.value == AppStatus.success
                        ? SizedBox(
                            child: Center(
                              child: Text(
                                "No Stocks",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
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
              })),
          Obx(() {
            return controller.stockHistory.isNotEmpty
                ? Container(
                    padding: context.padding(),
                    color: Colors.grey.shade200,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Investment",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              controller.totalInvestment.toString(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                : Container();
          }),
        ],
      ),
    );
  }

  void generateMenu(BuildContext context, StockController controller) {
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
                  await controller.deleteStockHistory();
                } catch (error) {
                  error.toString();
                }
              },
              child: Text("Clear History",
                  style: Theme.of(context).textTheme.bodyMedium!)),
        ]);
  }
}
