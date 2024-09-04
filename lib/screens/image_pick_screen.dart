import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/constants/extensions.dart';
import 'package:fruit_shop/controllers/home_controller.dart';
import 'package:get/get.dart';

class ImagePickScreen extends StatelessWidget {
  ImagePickScreen({super.key});

  static String name = "/image_screen";

  final List images = [
    {
      'name': "apple",
      'image': "assets/apple.png",
    },
    {
      'name': "orange",
      'image': "assets/orange.jpg",
    },
    {
      'name': "grapes",
      'image': "assets/grapes.png",
    },
    {
      'name': "banana",
      'image': "assets/banana.png",
    },
    {
      'name': "pineapple",
      'image': "assets/pineapple.png",
    },
    {
      'name': "pomegranate",
      'image': "assets/pomegranate.png",
    },
    {
      'name': "berika",
      'image': "assets/berika.jpeg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(),
      body: Container(
        padding: context.padding(),
        width: 1.sw,
        height: 1.sh,
        child: ListView.separated(
            itemBuilder: (c, i) {
              return ListTile(
                onTap: () {
                  controller.xFile.value = images[i]['image'];
                  Get.back();
                },
                leading: CircleAvatar(
                  child: Image.asset(
                    images[i]['image'],
                    fit: BoxFit.fill,
                  ),
                ),
                title: Text(
                  images[i]['name'],
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            },
            separatorBuilder: (c, i) => const Divider(
                  thickness: 0.5,
                ),
            itemCount: images.length),
      ),
    );
  }
}
