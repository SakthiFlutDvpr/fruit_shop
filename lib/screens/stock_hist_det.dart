import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/class_models/fruit_model.dart';

import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/utils/app_bar_title.dart';
import 'package:get/get.dart';

class StockHistoryDetailScreen extends StatelessWidget {
  const StockHistoryDetailScreen({super.key});
  static String name = "/stock_history_detail";

  @override
  Widget build(BuildContext context) {
    List data = Get.arguments['data'];
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          title: const AppBarTitle(title: "Stock History Detail")),
      body: Container(
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
    );
  }
}
