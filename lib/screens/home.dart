// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/network_services/cloud_storage.dart';
import 'package:fruit_shop/network_services/firebase_connectivity.dart';

import 'package:fruit_shop/screens/add_stock.dart';
import 'package:fruit_shop/screens/current_history.dart';
import 'package:fruit_shop/screens/sale_screen.dart';
import 'package:fruit_shop/screens/sales_history.dart';
import 'package:fruit_shop/screens/stock_history.dart';
import 'package:fruit_shop/screens/stock_screen.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:fruit_shop/utils/app_drawer.dart';
import 'package:fruit_shop/utils/fruit_card.dart';
import 'package:fruit_shop/utils/input_field.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static String name = "/home_screen";

  final TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        toolbarHeight: 70.h,
        foregroundColor: Colors.white,
        title: const AppBarTitle(title: "Gafur Shop"),
        actions: [
          IconButton(
              onPressed: () {
                generateMenu(context, homeController);
              },
              icon: const Icon(Icons.more_vert))
        ],
      ),
      drawer: AppDrawer(),
      body: PersistentTabView(
        context,
        handleAndroidBackButtonPress: true,
        navBarHeight: 75.h,
        margin: EdgeInsets.zero,
        hideNavigationBarWhenKeyboardAppears: true,
        popBehaviorOnSelectedNavBarItemPress: PopBehavior.once,
        animationSettings: const NavBarAnimationSettings(
            navBarItemAnimation:
                ItemAnimationSettings(duration: Duration(milliseconds: 400)),
            screenTransitionAnimation: ScreenTransitionAnimationSettings(
                duration: Duration(microseconds: 200))),
        floatingActionButton: Container(
          height: 70,
          width: 70,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(75))),
          child: FloatingActionButton(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(75))),
            onPressed: () {
              Get.toNamed(
                AddStockScreen.name,
              );
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 35.sp,
            ),
          ),
        ),
        screens: [
          SaleScreen(
            homeController: homeController,
          ),
          StockScreen(
            homeController: homeController,
          )
        ],
        items: [
          PersistentBottomNavBarItem(
              icon: Icon(
                Icons.sell,
                size: 25.sp,
              ),
              inactiveIcon: Icon(
                Icons.sell_outlined,
                size: 25.sp,
              ),
              title: "Sale",
              textStyle: Theme.of(context).textTheme.titleMedium,
              activeColorPrimary: Theme.of(context).colorScheme.primary,
              inactiveColorPrimary: Colors.black),
          PersistentBottomNavBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 25.sp,
              ),
              inactiveIcon: Icon(
                Icons.shopping_cart_outlined,
                size: 25.sp,
              ),
              title: "Stock",
              textStyle: Theme.of(context).textTheme.titleMedium,
              activeColorPrimary: Theme.of(context).colorScheme.primary,
              inactiveColorPrimary: Colors.black),
        ],
      ),
    );
  }

  void generateMenu(BuildContext context, HomeController homeController) {
    showMenu(
        context: context,
        position: RelativeRect.fromLTRB(1, 100.h, 0, 0),
        color: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        elevation: 3,
        menuPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 10.h),
        popUpAnimationStyle: AnimationStyle(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        ),
        items: [
          PopupMenuItem(
              padding: context.horizontalPadding(),
              onTap: () {
                Get.toNamed(CurrentHistory.name);
              },
              child: Text("Today Sales",
                  style: Theme.of(context).textTheme.bodyMedium!)),
          PopupMenuItem(
              padding: context.horizontalPadding(),
              onTap: () async {
                try {
                  homeController.deleteStocks();
                } catch (error) {
                  debugPrint(error.toString());
                }
              },
              child: Text("Clear All Stocks",
                  style: Theme.of(context).textTheme.bodyMedium!)),
          PopupMenuItem(
              padding: context.horizontalPadding(),
              onTap: () async {
                await FireStoreConnection.deletingStocksHistory();
              },
              child: Text(
                "Clear StocksHistory",
                style: Theme.of(context).textTheme.bodyMedium,
              )),
          PopupMenuItem(
              padding: context.horizontalPadding(),
              onTap: () async {
                await FireStoreConnection.deletingSalesHistory();
              },
              child: Text(
                "Clear SalesHistory",
                style: Theme.of(context).textTheme.bodyMedium,
              ))
        ]);
  }

  // void clearStock(BuildContext context, HomeController controller) {
  //   showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Dialog(
  //           insetAnimationDuration: const Duration(milliseconds: 100),
  //           insetAnimationCurve: Curves.decelerate,
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               AlertDialog(
  //                 insetPadding: EdgeInsets.zero,
  //                 title: Text(
  //                   "Stock Name",
  //                   style: Theme.of(context)
  //                       .textTheme
  //                       .headlineMedium!
  //                       .copyWith(color: Colors.black),
  //                 ),
  //                 content: InputField(
  //                   controller: stockController,
  //                   inputType: TextInputType.name,
  //                   hintText: "E.g. Apple",
  //                   border: true,
  //                   filled: false,
  //                   validator: (value) {
  //                     if (value.toString().isEmpty) {
  //                       return "Name Missing";
  //                     }
  //                     return null;
  //                   },
  //                   onSaved: (value) {},
  //                 ),
  //                 backgroundColor: Colors.white,
  //                 actionsAlignment: MainAxisAlignment.spaceBetween,
  //                 actions: [
  //                   TextButton(
  //                       onPressed: () {
  //                         stockController.clear();

  //                         Get.back();
  //                       },
  //                       style: TextButton.styleFrom(
  //                         padding: EdgeInsets.zero,
  //                         backgroundColor: Colors.transparent,
  //                       ),
  //                       child: Text(
  //                         "Cancel",
  //                         style: Theme.of(context)
  //                             .textTheme
  //                             .titleMedium!
  //                             .copyWith(
  //                                 fontWeight: FontWeight.bold,
  //                                 color: CupertinoColors.activeBlue),
  //                       )),
  //                   TextButton(
  //                       onPressed: () async {
  //                         try {
  //                           controller.deleteSelectedStock(
  //                               stockController.text.toString().toLowerCase());
  //                         } catch (error) {
  //                           debugPrint(error.toString());
  //                         }
  //                         stockController.clear();
  //                         Get.back();
  //                       },
  //                       style: TextButton.styleFrom(
  //                         padding: EdgeInsets.zero,
  //                         backgroundColor: Colors.transparent,
  //                       ),
  //                       child: Text(
  //                         "Delete",
  //                         style: Theme.of(context)
  //                             .textTheme
  //                             .titleMedium!
  //                             .copyWith(
  //                                 fontWeight: FontWeight.bold,
  //                                 color:
  //                                     Theme.of(context).colorScheme.tertiary),
  //                       )),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         );
  //       });
  // }
}
