import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/class_models/fruit_model.dart';

import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:get/get.dart';

class StockHistoryDetailScreen extends StatefulWidget {
  const StockHistoryDetailScreen({super.key});

  static String name = "/stock_history_detail";

  @override
  State<StockHistoryDetailScreen> createState() =>
      _StockHistoryDetailScreenState();
}

class _StockHistoryDetailScreenState extends State<StockHistoryDetailScreen> {
  List<Stock> data = Get.arguments['data'];
  double todayInvestment = 0.0;

  @override
  void initState() {
    for (var datum in data) {
      todayInvestment += datum.investment;
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
          title: const AppBarTitle(title: "Stock History Detail")),
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
                        'Investment',
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
                        Stock datum = data[index];

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
                                datum.investment.toString(),
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
                      "Day Investment",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      todayInvestment.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
