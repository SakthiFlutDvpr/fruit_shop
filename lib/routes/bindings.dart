import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
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

