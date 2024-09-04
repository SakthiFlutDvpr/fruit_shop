import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/constants/theme.dart';
import 'package:fruit_shop/firebase_options.dart';
import 'package:fruit_shop/routes/router.dart';
import 'package:fruit_shop/screens/home.dart';
import 'package:fruit_shop/screens/unknown_screen.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await DataBaseConnection().getDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: const Size(375, 812),
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Gafur Shop',
          initialRoute: HomeScreen.name,
          getPages: AppRouter.getPages,
          unknownRoute: GetPage(
              name: UnknownScreen.name, page: () => const UnknownScreen()),
          theme: AppTheme.lightTheme(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

String androidId = "1:510228184214:android:4f239aada191c40bbf96b7";
String iosId = "1:510228184214:ios:400ef4f9c92bf1e3bf96b7";
