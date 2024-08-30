import 'package:fruit_shop/routes/bindings.dart';
import 'package:fruit_shop/screens/add_stock.dart';
import 'package:fruit_shop/screens/home.dart';
import 'package:fruit_shop/screens/sales_hist_det.dart';
import 'package:fruit_shop/screens/sales_history.dart';
import 'package:fruit_shop/screens/stock_detail_screen.dart';
import 'package:fruit_shop/screens/stock_hist_det.dart';
import 'package:fruit_shop/screens/stock_history.dart';
import 'package:get/get.dart';

class AppRouter {
  static final getPages = <GetPage>[
    GetPage(
        name: HomeScreen.name,
        page: () => const HomeScreen(),
        binding: HomeBinding()),
    GetPage(
      name: AddStockScreen.name,
      page: () => AddStockScreen(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 300),
      transition: Transition.leftToRightWithFade,
    ),
    GetPage(
      name: StockDetailScreen.name,
      page: () => const StockDetailScreen(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: SalesHistoryScreen.name,
      page: () => const SalesHistoryScreen(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: SalesHistoryDetailScreen.name,
      page: () => const SalesHistoryDetailScreen(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: StockHistoryScreen.name,
      page: () => const StockHistoryScreen(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 100),
    ),
    GetPage(
      name: StockHistoryDetailScreen.name,
      page: () => const StockHistoryDetailScreen(),
      binding: HomeBinding(),
      transitionDuration: const Duration(milliseconds: 300),
    )
  ];
}
