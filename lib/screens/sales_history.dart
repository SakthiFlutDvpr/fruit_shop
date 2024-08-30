import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:fruit_shop/utils/history_tile.dart';
import 'package:get/get.dart';

class SalesHistoryScreen extends StatelessWidget {
  const SalesHistoryScreen({super.key});
  static String name = "/sales_history";

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          title: const AppBarTitle(title: "Sales History")),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
            padding: context.padding(),
            width: 1.sw,
            height: 1.sh,
            child: homeController.salesHistory.isNotEmpty
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return SalesHistoryTile(
                          history: homeController.salesHistory[index]);
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        thickness: 1.5,
                        color: Colors.grey,
                      );
                    },
                    itemCount: homeController.salesHistory.length)
                : SizedBox(
                    child: Center(
                      child: Text(
                        "No Sales",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  )),
      ),
    );
  }
}
