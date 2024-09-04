import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/class_models/sale_model.dart';

import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:get/get.dart';

class SalesHistoryDetailScreen extends StatefulWidget {
  const SalesHistoryDetailScreen({super.key});
  static String name = "/sales_history_detail";

  @override
  State<SalesHistoryDetailScreen> createState() =>
      _SalesHistoryDetailScreenState();
}

class _SalesHistoryDetailScreenState extends State<SalesHistoryDetailScreen> {
  List<Sale> data = Get.arguments['data'];
  double todayEarning = 0.0;

  @override
  void initState() {
    for (var datum in data) {
      todayEarning += datum.price;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          title: const AppBarTitle(title: "Sales History Detail")),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            padding: context.padding(),
            width: 1.sw,
            height: 1.sh,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.h),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ('S.No').toString(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'Fruit',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'Quantity',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'SalePrice',
                        style: Theme.of(context).textTheme.headlineMedium,
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
                        Sale datum = data[index];

                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (index + 1).toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                datum.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                datum.quantity.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                datum.price.toString(),
                                style: Theme.of(context).textTheme.titleMedium,
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
                      itemCount: data.length),
                ),
              ],
            ),
          ),
          Container(
            padding: context.padding(),
            color: Colors.grey.shade200,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Day Earnings",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      todayEarning.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
