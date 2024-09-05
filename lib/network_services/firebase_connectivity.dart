import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fruit_shop/class_models/fruit_model.dart';
import 'package:fruit_shop/class_models/sale_model.dart';

class FireStoreConnection {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static String stockInfo = "stock_info";
  static String salesInfo = "sales_info";
  static String stockHistory = "stock_history";
  static String salesHistory = "sales_history";

  static CollectionReference stockCollection = firestore.collection(stockInfo);
  static CollectionReference salesCollection = firestore.collection(salesInfo);
  static CollectionReference stockHistoryCollection =
      firestore.collection(stockHistory);
  static CollectionReference salesHistoryCollection =
      firestore.collection(salesHistory);

  // stock collection operation >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  static Future<void> addingStock(FruitModel fruitCardModel) async {
    DocumentSnapshot documentId =
        await stockCollection.doc(fruitCardModel.stockName).get();

    if (documentId.exists) {
      Map<String, dynamic> data = (documentId.data() as Map<String, dynamic>);
      var quant = data['quantity'] + fruitCardModel.stockQuantity;
      var invest = data['investment'] + fruitCardModel.investment;
      await documentId.reference.update({
        'name': fruitCardModel.stockName,
        'image': fruitCardModel.stockImage,
        'quantity': quant,
        'investment': invest
      });
    } else {
      await stockCollection.doc(fruitCardModel.stockName).set({
        'name': fruitCardModel.stockName,
        'image': fruitCardModel.stockImage,
        'quantity': fruitCardModel.stockQuantity,
        'investment': fruitCardModel.investment
      });
    }
  }

  static Future<void> minusWithSales(SaleModel saleModel) async {
    DocumentSnapshot documentId =
        await stockCollection.doc(saleModel.name).get();

    if (documentId.exists) {
      Map<String, dynamic> data = (documentId.data() as Map<String, dynamic>);
      var quant = data['quantity'] - saleModel.quantity;

      await documentId.reference.update({
        'quantity': quant,
      });
    }
  }

  static Future<List<Map>> gettingStocks() async {
    QuerySnapshot querySnapshot = await stockCollection.get();

    List<Map> data = [];

    debugPrint('data fetched ...........................................');

    for (var doc in querySnapshot.docs) {
      debugPrint(doc.id.toString());
      Map datum = (doc.data() as Map);
      data.add(datum);
    }

    return data;
  }

  static Future<Map<String, dynamic>> gettingSelectedStock(
      String document) async {
    DocumentSnapshot documentSnapshot =
        await stockCollection.doc(document).get();

    return documentSnapshot.data() as Map<String, dynamic>;
  }

  static Future<void> deletingStocks() async {
    QuerySnapshot querySnapshot = await stockCollection.get();

    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  static Future<void> deletingSelectedStock(String document) async {
    await stockCollection.doc(document).delete();
  }

  // sales collection operation >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  static Future<void> updatingSales(SaleModel saleModel) async {
    DocumentSnapshot documentSnapshot =
        await salesCollection.doc(saleModel.name).get();

    if (documentSnapshot.exists) {
      var oldQunatity = (documentSnapshot.data() as Map)['quantity'];
      var oldPrice = (documentSnapshot.data() as Map)['price'];
      await documentSnapshot.reference.update({
        'quantity': oldQunatity + saleModel.quantity,
        'price': oldPrice + saleModel.price
      });
    } else {
      await salesCollection.doc(saleModel.name).set({
        'name': saleModel.name,
        'quantity': saleModel.quantity,
        'price': saleModel.price
      });
    }
  }

  static Future<List<Map<String, dynamic>>> gettingSales() async {
    List<Map<String, dynamic>> data = [];

    QuerySnapshot querySnapshot = await salesCollection.get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> datum = (doc.data() as Map<String, dynamic>);
      data.add(datum);
    }
    return data;
  }

  static Future<Map> gettingSelectedSale(String document) async {
    DocumentSnapshot documentSnapshot =
        await salesCollection.doc(document).get();

    return documentSnapshot.data() as Map;
  }

  static Future<void> deletingSales() async {
    QuerySnapshot querySnapshot = await salesCollection.get();

    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  // operation on collection stockhistory >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  static Future<void> addingStockHistory(FruitModel fruitModel) async {
    String document = DateTime.now().toString().substring(0, 10);

    DocumentSnapshot snapshot =
        await stockHistoryCollection.doc(document).get();

    if (snapshot.exists) {
      List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
          (snapshot.data() as Map<String, dynamic>)['stocks']);

      data.add({
        'name': fruitModel.stockName,
        'quantity': fruitModel.stockQuantity,
        'investment': fruitModel.investment,
        'date': Timestamp.fromDate(DateTime.now())
      });
      await snapshot.reference.update({
        'stocks': data,
      });
    } else {
      await stockHistoryCollection.doc(document).set({
        'stocks': [
          {
            'name': fruitModel.stockName,
            'quantity': fruitModel.stockQuantity,
            'investment': fruitModel.investment,
            'date': Timestamp.fromDate(DateTime.now())
          }
        ]
      });
    }
  }

  static Future<List<Map<String, dynamic>>> gettingStockHistory() async {
    List<Map<String, dynamic>> data = [];
    QuerySnapshot querySnapshot = await stockHistoryCollection.get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> datum = (doc.data() as Map<String, dynamic>);
      Map<String, dynamic> mapDatum = {
        'id': doc.id.toString(),
        'stocks': datum['stocks'] as List,
      };
      data.add(mapDatum);
    }
    return data;
  }

  static Future<void> deletingStocksHistory() async {
    QuerySnapshot querySnapshot = await stockHistoryCollection.get();

    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }

  // operation on collection saleshistory >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  static Future<void> addingSalesHistory(
      List<Map<String, dynamic>> salesItems) async {
    String document = DateTime.now().toString().substring(0, 10);

    DocumentSnapshot snapshot =
        await salesHistoryCollection.doc(document).get();

    if (snapshot.exists) {
      debugPrint('update exist');
      Map<String, dynamic> data = (snapshot.data() as Map<String, dynamic>);
      List<dynamic> existingSaleItems = data['saleItems'];

      existingSaleItems.addAll(salesItems);
      for (var datum in existingSaleItems) {
        debugPrint('this my entry');

        debugPrint(datum.toString());
      }

      await snapshot.reference.update({
        'saleItems': existingSaleItems,
        'date': Timestamp.fromDate(DateTime.now())
      });
    } else {
      await salesHistoryCollection.doc(document).set({
        'saleItems': salesItems,
        'date': Timestamp.fromDate(DateTime.now())
      });

      debugPrint("history inserted");
      for (var datum in salesItems) {
        debugPrint('this my entry');

        debugPrint(datum.toString());
      }
    }
  }

  static Future<List<Map<String, dynamic>>> gettingSalesHistory() async {
    List<Map<String, dynamic>> data = [];
    QuerySnapshot querySnapshot = await salesHistoryCollection.get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> datum = (doc.data() as Map<String, dynamic>);
      Map<String, dynamic> mapDatum = {
        'id': doc.id.toString(),
        'sales': datum['saleItems'] as List,
      };
      data.add(mapDatum);
    }
    return data;
  }

  static Future<void> deletingSalesHistory() async {
    QuerySnapshot querySnapshot = await salesHistoryCollection.get();

    for (final doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
