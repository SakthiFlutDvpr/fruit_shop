class FruitModel {
  final String stockName;
  final String stockImage;
  final double stockQuantity;
  final double investment;

  FruitModel(
      {required this.stockName,
      required this.stockImage,
      required this.stockQuantity,
      required this.investment});

  factory FruitModel.fromJson(Map json) {
    return FruitModel(
        stockName: json['name'],
        stockImage: json['image'],
        stockQuantity: json['quantity'],
        investment: json['investment']);
  }
}

class FruitDetail {
  final String stockName;
  final String stockImage;
  final double stockQuantity;
  final double investment;
  final double saleQuantity;
  final double salePrice;
  final double remainingQuantity;

  FruitDetail(
      {required this.stockName,
      required this.stockImage,
      required this.stockQuantity,
      required this.investment,
      required this.saleQuantity,
      required this.salePrice,
      required this.remainingQuantity});
}

class StockHistory {
  final String id;

  List<Stock> stocks;

  StockHistory({required this.id, required this.stocks});

  factory StockHistory.fromJson(Map json) {
    return StockHistory(
        id: json['id'],
        stocks: List.from(json['stocks'] as List).map((e) {
          return Stock.fromJson(e);
        }).toList());
  }
}

class Stock {
  final String name;
  final double quantity;
  final double investment;
  final String date;

  Stock(
      {required this.name,
      required this.quantity,
      required this.investment,
      required this.date});

  factory Stock.fromJson(Map json) {
    return Stock(
        name: json['name'],
        quantity: json['quantity'],
        investment: json['investment'],
        date: json['date'].toString());
  }
}
