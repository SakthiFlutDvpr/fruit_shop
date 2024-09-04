import 'package:fruit_shop/network_services/local_storage/sqlite_connectivity.dart';

import 'package:sqflite/sqflite.dart';

class SalesOperation {
  // salesTable operations >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  // inserting data ...........................................................

  Future<int> insertData(
      String fruit, String date, double saleQuant, double salePrice) async {
    Database db = await DataBaseConnection().getDatabase();

    // record that exist

    List<Map<String, dynamic>> existsRecord = await db.query(
        DataBaseConnection.salesTable,
        where: 'fruit = ? AND date = ?',
        whereArgs: [fruit, date]);

    if (existsRecord.isNotEmpty) {
      Map<String, dynamic> record = existsRecord.first;
      double newSaleQuant = record['salequantity'] + saleQuant;
      double newSalePrice = record['saleprice'] + salePrice;

      final int = await db.update(DataBaseConnection.salesTable,
          {'salequantity': newSaleQuant, 'saleprice': newSalePrice},
          where: 'fruit = ? AND date = ?', whereArgs: [fruit, date]);
      return int;
    } else {
      final int = await db.insert(
          DataBaseConnection.salesTable,
          {
            'fruit': fruit,
            'date': date,
            'salequantity': saleQuant,
            'saleprice': salePrice
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      return int;
    }
  }

  // getting fields ...........................................................

  Future<List> getAllFields() async {
    Database db = await DataBaseConnection().getDatabase();

    List<Map<String, dynamic>> fields = await db
        .rawQuery('PRAGMA table_info(${DataBaseConnection.salesTable});');

    return fields;
  }

  // getting all the data ................................................................................

  Future<List> getAllData() async {
    Database db = await DataBaseConnection().getDatabase();

    List<Map<String, dynamic>> records =
        await db.query(DataBaseConnection.salesTable);

    return records;
  }

  // getting specified data ...............................................................................

  Future<Map<String, dynamic>> getData(String fruit, String date) async {
    Database db = await DataBaseConnection().getDatabase();

    List<Map<String, dynamic>> record = await db.query(
        DataBaseConnection.salesTable,
        where: 'fruit = ? AND date = ?',
        whereArgs: [fruit, date]);

    return record.first;
  }

  // deleting all the data ...................................................................................

  Future<void> deleteAllData() async {
    Database db = await DataBaseConnection().getDatabase();

    await db.delete(DataBaseConnection.salesTable);
    await db.execute(
        'DELETE FROM sqlite_sequence WHERE name="$DataBaseConnection.salesTable"');
  }
}
