import 'package:flutter/material.dart';
import 'package:fruit_shop/class_models/fruit_model.dart';
import 'package:fruit_shop/constants/app_status.dart';
import 'package:fruit_shop/network_services/firebase_connectivity.dart';
import 'package:get/get.dart';

class StockController extends GetxController {
  Rx<AppStatus> status = AppStatus.initial.obs;
  List<StockHistory> stockHistory = <StockHistory>[].obs;

  RxDouble totalInvestment = 0.0.obs;

  RxDouble todayInvestment = 0.0.obs;

  historyCalculation() {
    for (var model in stockHistory) {
      for (var stock in model.stocks) {
        todayInvestment.value += stock.investment;
      }
      totalInvestment.value += todayInvestment.value;
    }
  }

  getStockHistory() async {
    stockHistory.clear();

    List<Map<String, dynamic>> histories =
        await FireStoreConnection.gettingStockHistory();

    for (var history in histories) {
      stockHistory.add(StockHistory.fromJson(history));
    }
  }

  deleteStockHistory() async {
    await FireStoreConnection.deletingStocksHistory();
    await getStockHistory();
  }

  @override
  void onInit() async {
    super.onInit();

    status.value = AppStatus.loading;
    try {
      await getStockHistory();
    } catch (error) {
      debugPrint(error.toString());
    }
    historyCalculation();
    status.value = AppStatus.success;
  }
}
