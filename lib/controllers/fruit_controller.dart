import 'package:flutter/material.dart';

import 'package:fruit_shop/network_services/firebase_connectivity.dart';
import 'package:get/get.dart';

class FruitController extends GetxController {
  late Map argument;
  Rx<String> fruitName = ''.obs;

  Rx<double> stocked = (0.0).obs;
  Rx<double> sold = (0.0).obs;
  Rx<double> remaining = (0.0).obs;
  Rx<double> earning = (0.0).obs;

  getStockDetail(String fruitModel) async {
    Map stock = await FireStoreConnection.gettingSelectedStock(fruitModel);

    debugPrint(stock['quantity'].toString());
    debugPrint(stock['investment'].toString());
    fruitName.value = stock['name'];

    stocked.value = stock['quantity'];

    Map sale = await FireStoreConnection.gettingSelectedSale(fruitModel);

    sold.value = sale['quantity'] ?? 0.0;
    earning.value = sale['price'];

    debugPrint(sale['quantity'].toString());
    debugPrint(sale['price'].toString());
  }

  @override
  void onInit() async {
    super.onInit();

    argument = Get.arguments;
    try {
      await getStockDetail(argument['data']);
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}
