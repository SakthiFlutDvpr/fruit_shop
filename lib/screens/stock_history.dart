import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:fruit_shop/utils/history_tile.dart';
import 'package:get/get.dart';

class StockHistoryScreen extends StatelessWidget {
  const StockHistoryScreen({super.key});
  static String name = "/stock_history";

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          title: const AppBarTitle(title: "Stock History")),
      body: Container(
          padding: context.padding(),
          width: 1.sw,
          height: 1.sh,
          child: homeController.stockHistory.isNotEmpty
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    return StockHistoryTile(
                        history: homeController.stockHistory[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 1.5,
                      color: Colors.grey,
                    );
                  },
                  itemCount: homeController.stockHistory.length)
              : SizedBox(
                  child: Center(
                    child: Text(
                      "No Stocks",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                )),
    );
  }
}
