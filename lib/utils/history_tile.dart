import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/class_models/fruit_model.dart';
import 'package:fruit_shop/class_models/sale_model.dart';
import 'package:fruit_shop/screens/sales_hist_det.dart';
import 'package:fruit_shop/screens/stock_hist_det.dart';
import 'package:get/get.dart';

class StockHistoryTile extends StatelessWidget {
  const StockHistoryTile({super.key, required this.history});

  final StockHistory history;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Get.toNamed(StockHistoryDetailScreen.name,
              arguments: {'data': history.stocks});
        },
        contentPadding: EdgeInsets.zero,
        title: Text(
          history.id,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 25.sp,
        ));
  }
}

class SalesHistoryTile extends StatelessWidget {
  const SalesHistoryTile({super.key, required this.history});

  final SalesHistory history;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Get.toNamed(SalesHistoryDetailScreen.name,
              arguments: {'data': history.sales});
        },
        contentPadding: EdgeInsets.zero,
        title: Text(
          history.id,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          size: 25.sp,
        ));
  }
}
