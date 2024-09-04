import 'package:flutter/material.dart';
import 'package:fruit_shop/class_models/fruit_model.dart';

import 'package:fruit_shop/class_models/sale_model.dart';
import 'package:fruit_shop/constants/app_status.dart';
import 'package:fruit_shop/network_services/firebase_connectivity.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<FruitModel> stockList = <FruitModel>[].obs;

  List<SaleModel> salesList = <SaleModel>[].obs;

  Rx<String> xFile = ''.obs;
  Rx<Color> imgColor = Colors.grey.obs;

  Rx<AppStatus> status = AppStatus.initial.obs;

  addStocks(FruitModel fruitModel) async {
    await FireStoreConnection.addingStock(fruitModel);
  }

  addStockHistory(FruitModel fruitModel) async {
    await FireStoreConnection.addingStockHistory(fruitModel);
  }

  getStocks() async {
    stockList.clear();
    List<Map> fruits = await FireStoreConnection.gettingStocks();

    for (var fruit in fruits) {
      stockList.add(FruitModel.fromJson(fruit));
    }
  }

  updateSales(SaleModel saleModel) async {
    await FireStoreConnection.updatingSales(saleModel);
    await FireStoreConnection.minusWithSales(saleModel);
  }

  addSalesHistory() async {
    List<Map<String, dynamic>> salesItems =
        await FireStoreConnection.gettingSales();
    await FireStoreConnection.addingSalesHistory(salesItems);
  }

  deleteStocks() async {
    await FireStoreConnection.deletingStocks();
    await getStocks();
  }

  deleteSelectedStock(String stock) async {
    await FireStoreConnection.deletingSelectedStock(stock);
    await getStocks();
  }

  @override
  void onInit() async {
    super.onInit();

    status.value = AppStatus.loading;
    try {
      await getStocks();
    } catch (error) {
      debugPrint(error.toString());
    }
    status.value = AppStatus.success;
  }
}
