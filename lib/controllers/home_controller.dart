import 'package:flutter/material.dart';
import 'package:fruit_shop/class_models/fruit_model.dart';

import 'package:fruit_shop/class_models/sale_model.dart';
import 'package:fruit_shop/constants/app_status.dart';
import 'package:fruit_shop/network_services/firebase_connectivity.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final TextEditingController fruitNameController = TextEditingController();
  final TextEditingController fruitQuantityController = TextEditingController();
  final TextEditingController fruitInvestingController =
      TextEditingController();

  List<FruitModel> stockList = <FruitModel>[].obs;

  List<SaleModel> salesList = <SaleModel>[].obs;

  List<StockHistory> stockHistory = <StockHistory>[].obs;

  List<SalesHistory> salesHistory = <SalesHistory>[].obs;

  XFile? xFile;

  Rx<AppStatus> status = AppStatus.initial.obs;

  Future<Map> getStockDetail(FruitModel fruitModel) async {
    Map data =
        await FireStoreConnection.gettingSelectedSale(fruitModel.stockName);

    debugPrint(data['quantity'].toString());
    debugPrint(data['price'].toString());

    Map stockDetail = {
      'name': fruitModel.stockName,
      'stockquantity': fruitModel.stockQuantity,
      'investment': fruitModel.investment,
      'salequantity': data['quantity'],
      'saleprice': data['price'],
      'remainingquantity': fruitModel.stockQuantity - data['quantity']
    };
    return stockDetail;
  }

  // getSalesHistory() async {
  //   salesList.clear();
  //   final results = await DataBaseConnection().getAllData();
  //   List<SaleModel> histories = results.map((map) {
  //     return SaleModel.fromJson(map);
  //   }).toList();
  //   salesList.addAll(histories);
  // }

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

  getStockHistory() async {
    stockHistory.clear();

    List<Map<String, dynamic>> histories =
        await FireStoreConnection.gettingStockHistory();

    for (var history in histories) {
      stockHistory.add(StockHistory.fromJson(history));
    }
  }

  updateSales(SaleModel saleModel) async {
    await FireStoreConnection.updatingSales(saleModel);
  }

  // getSales() async {
  //   salesList.clear();
  //   List<Map> sales = await FireStoreConnection.gettingSales();

  //   for (var sale in sales) {
  //     salesList.add(SaleModel.fromJson(sale));
  //   }
  // }

  addSalesHistory() async {
    List<Map<String, dynamic>> salesItems =
        await FireStoreConnection.gettingSales();
    await FireStoreConnection.addingSalesHistory(salesItems);
  }

  getSalesHistory() async {
    salesHistory.clear();

    List<Map<String, dynamic>> histories =
        await FireStoreConnection.gettingSalesHistory();

    for (var history in histories) {
      salesHistory.add(SalesHistory.fromJson(history));
    }
  }

  @override
  void onInit() async {
    super.onInit();
    status.value = AppStatus.loading;
    await getStocks();
  }
}
