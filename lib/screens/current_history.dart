import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/class_models/sale_model.dart';
import 'package:fruit_shop/constants/app_status.dart';

import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/current_controller.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:get/get.dart';

class CurrentHistory extends StatelessWidget {
  const CurrentHistory({super.key});
  static String name = "/current_history";

  @override
  Widget build(BuildContext context) {
    CurrentController controller = Get.find<CurrentController>();

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            title: const AppBarTitle(title: "Today History")),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
                padding: context.padding(),
                width: 1.sw,
                height: 1.sh,
                child: Obx(() {
                  return controller.todaySales.isNotEmpty &&
                          controller.status.value == AppStatus.success
                      ? Container(
                          padding: context.padding(),
                          width: 1.sw,
                          height: 1.sh,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10.h),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      ('S.No').toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      'Fruit',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      'Sold',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      'Earnings',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              Expanded(
                                child: ListView.separated(
                                    primary: true,
                                    itemBuilder: (context, index) {
                                      SaleModel datum =
                                          controller.todaySales[index];

                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              (index + 1).toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            Text(
                                              datum.name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            Text(
                                              datum.quantity.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            Text(
                                              datum.price.toString(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider(
                                        thickness: 1.0,
                                        color: Colors.grey,
                                      );
                                    },
                                    itemCount: controller.todaySales.length),
                              ),
                            ],
                          ))
                      : controller.todaySales.isEmpty &&
                              controller.status.value == AppStatus.success
                          ? SizedBox(
                              child: Center(
                                child: Text(
                                  "No Sales  Yet",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
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
              return Container(
                padding: context.padding(),
                color: Colors.grey.shade200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Today Earnings",
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(
                          controller.earning.toString(),
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                      ],
                    )
                  ],
                ),
              );
            })
          ],
        ));
  }
}
