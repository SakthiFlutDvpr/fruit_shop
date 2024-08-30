class SaleModel {
  final String name;
  final double quantity;
  final double price;

  SaleModel({
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory SaleModel.fromJson(Map json) {
    return SaleModel(
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}

class SalesHistory {
  final String id;

  List<Sale> sales;

  SalesHistory({required this.id, required this.sales});

  factory SalesHistory.fromJson(Map json) {
    return SalesHistory(
        id: json['id'],
        sales: List.from(json['sales'] as List).map((e) {
          return Sale.fromJson(e);
        }).toList());
  }
}

class Sale {
  final String name;
  final double quantity;
  final double price;
  final String date;

  Sale(
      {required this.name,
      required this.quantity,
      required this.price,
      required this.date});

  factory Sale.fromJson(Map json) {
    return Sale(
        name: json['name'],
        quantity: json['quantity'],
        price: json['price'],
        date: json['date'].toString());
  }
}
