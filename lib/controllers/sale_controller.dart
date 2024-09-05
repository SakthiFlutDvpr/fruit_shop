import 'package:flutter/material.dart';
import 'package:fruit_shop/class_models/sale_model.dart';
import 'package:fruit_shop/constants/app_status.dart';
import 'package:fruit_shop/network_services/firebase_connectivity.dart';
import 'package:get/get.dart';

class SaleController extends GetxController {
  Rx<AppStatus> status = AppStatus.initial.obs;
  List<SalesHistory> salesHistory = <SalesHistory>[].obs;

  RxDouble totalEarning = 0.0.obs;

  RxDouble todayEarning = 0.0.obs;

  historyCalculation() {
    totalEarning.value = 0.0;
    for (var model in salesHistory) {
      todayEarning.value = 0.0;
      for (var sale in model.sales) {
        todayEarning.value += sale.price;
      }
      totalEarning.value += todayEarning.value;
    }
  }

  getSalesHistory() async {
    salesHistory.clear();

    List<Map<String, dynamic>> histories =
        await FireStoreConnection.gettingSalesHistory();

    for (var history in histories) {
      salesHistory.add(SalesHistory.fromJson(history));
    }
  }

  deleteSalesHistory() async {
    await FireStoreConnection.deletingSalesHistory();
    await getSalesHistory();
  }

  @override
  void onInit() async {
    super.onInit();

    status.value = AppStatus.loading;
    try {
      await getSalesHistory();
    } catch (error) {
      debugPrint(error.toString());
    }
    historyCalculation();
    status.value = AppStatus.success;
  }
}
