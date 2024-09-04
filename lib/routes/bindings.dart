import 'package:fruit_shop/controllers/current_controller.dart';
import 'package:fruit_shop/controllers/fruit_controller.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:fruit_shop/controllers/sale_controller.dart';
import 'package:fruit_shop/controllers/stock_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

class StockHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StockController>(() => StockController());
  }
}

class SalesHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SaleController>(() => SaleController());
  }
}

class CurrentHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurrentController>(() => CurrentController());
  }
}

class FruitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FruitController>(() => FruitController());
  }
}

// class Router {
//   static final pages = [
//     GetPage(
//       name: "/",
//       page: () => HomeScreen(),
//       binding: BindingOne(),
//       // middlewares: [AuthMiddleware()])
//     )
//   ];
// }

// // class AuthMiddleware extends GetMiddleware {
// //   RouteSettings? redirect(String? name) {
// //     return const RouteSettings(name: "/");
// //   }

