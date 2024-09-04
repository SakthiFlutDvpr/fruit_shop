import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/constants/app_status.dart';

import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/sale_controller.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:fruit_shop/utils/history_tile.dart';
import 'package:get/get.dart';

class SalesHistoryScreen extends StatelessWidget {
  const SalesHistoryScreen({super.key});
  static String name = "/sales_history";

  @override
  Widget build(BuildContext context) {
    SaleController controller = Get.find<SaleController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const AppBarTitle(title: "Sales History"),
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
                return controller.salesHistory.isNotEmpty &&
                        controller.status.value == AppStatus.success
                    ? ListView.separated(
                        itemBuilder: (context, index) {
                          return SalesHistoryTile(
                              history: controller.salesHistory[index]);
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 1.5,
                            color: Colors.grey,
                          );
                        },
                        itemCount: controller.salesHistory.length)
                    : controller.salesHistory.isEmpty &&
                            controller.status.value == AppStatus.success
                        ? SizedBox(
                            child: Center(
                              child: Text(
                                "No Sales",
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
            return controller.salesHistory.isNotEmpty
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
                              "Total Earnings",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              controller.totalEarning.toString(),
                              style: Theme.of(context).textTheme.headlineMedium,
                            )
                          ],
                        )
                      ],
                    ),
                  )
                : Container();
          })
        ],
      ),
    );
  }

  void generateMenu(BuildContext context, SaleController controller) {
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
                  await controller.deleteSalesHistory();
                } catch (error) {
                  error.toString();
                }
              },
              child: Text("Clear History",
                  style: Theme.of(context).textTheme.bodyMedium!)),
        ]);
  }
}
