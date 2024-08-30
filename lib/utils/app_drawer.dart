import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/utils/filled_button.dart';
import 'package:get/get.dart';

class AppDrawer extends StatelessWidget {
  AppDrawer({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 0.8.sw,
      color: Theme.of(context).colorScheme.secondary,
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Mohammed Sahil Syed "),
            accountEmail: Text("syyy6339@gmail.com "),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
            ),
          ),
          const ExpansionTile(title: Text("Settlement")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: UpdateButton(
              text: "End This Day",
              isDisable: false,
              onTap: () async {
                try {
                  await homeController.addSalesHistory();
                } catch (e) {
                  debugPrint(e.toString());
                }
                Get.back();
              },
            ),
          )
        ],
      ),
    );
  }
}
