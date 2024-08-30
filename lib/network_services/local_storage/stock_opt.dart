import 'package:fruit_shop/class_models/fruit_model.dart';
import 'package:fruit_shop/network_services/sqlite_connectivity.dart';
import 'package:sqflite/sqflite.dart';

class StockOperation {
  Future<int> insertData(FruitModel fruitModel) async {
    Database db = await DataBaseConnection().getDatabase();

    List<Map<String, dynamic>> records = await db.query(
        DataBaseConnection.stockTable,
        where: 'fruit = ?',
        whereArgs: [fruitModel.stockName]);
    if (records.isNotEmpty) {
      Map<String, dynamic> record = records.first;
      double newStockQuantity =
          record['stockquantity'] + fruitModel.stockQuantity;
      double newInvestment = record['investment'] + fruitModel.investment;
      int res = await db.update(DataBaseConnection.stockTable, {
        'stockquantity': newStockQuantity,
        'investment': newInvestment,
        'date': DateTime.now().toString().substring(0, 10)
      });
    }

    int result = await db.insert(DataBaseConnection.stockTable, {
      'fruit': fruitModel.stockName,
      'stockquantity': fruitModel.stockQuantity,
      'investment': fruitModel.investment,
      'date': DateTime.now().toString().substring(0, 10)
    });

    return result;
  }

  // getting all data .........................................................

  Future<List<Map>> getAllData() async {
    Database db = await DataBaseConnection().getDatabase();

    List<Map> data = await db.query(DataBaseConnection.stockTable);
    return data;
  }

  // getting specified data ...................................................

  Future<Map> getData(String fruit) async {
    Database db = await DataBaseConnection().getDatabase();

    List<Map> data = await db.query(DataBaseConnection.stockTable,
        where: 'fruit = ?', whereArgs: [fruit]);

    return data.first;
  }
}
