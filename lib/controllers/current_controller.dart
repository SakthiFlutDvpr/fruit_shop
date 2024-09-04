import 'package:flutter/material.dart';
import 'package:fruit_shop/class_models/sale_model.dart';
import 'package:fruit_shop/constants/app_status.dart';
import 'package:fruit_shop/network_services/firebase_connectivity.dart';
import 'package:get/get.dart';

class CurrentController extends GetxController {
  Rx<AppStatus> status = AppStatus.initial.obs;

  List<SaleModel> todaySales = <SaleModel>[].obs;
  RxDouble earning = 0.0.obs;

  getSales() async {
    todaySales.clear();
    List<Map<String, dynamic>> sales = await FireStoreConnection.gettingSales();

    for (var sale in sales) {
      todaySales.add(SaleModel(
          name: sale['name'],
          quantity: sale['quantity'],
          price: sale['price']));
    }
  }

  historyCalculation() {
    for (var sale in todaySales) {
      earning.value += sale.price;
    }
  }

  @override
  void onInit() async {
    super.onInit();

    status.value = AppStatus.loading;
    try {
      await getSales();
    } catch (error) {
      debugPrint(error.toString());
    }
    status.value = AppStatus.success;
    historyCalculation();
  }
}
