import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fruit_shop/class_models/fruit_model.dart';

import 'package:get/get.dart';

class FruitCard extends StatelessWidget {
  const FruitCard({super.key, required this.fruitCardModel});

  final FruitModel fruitCardModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.secondary,
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.asset(
                    fruitCardModel.stockImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey,
                      child: Text(
                        "No Image",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )),
            ),
            Text(
              fruitCardModel.stockName.capitalize.toString(),
              maxLines: 1,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(overflow: TextOverflow.ellipsis),
            )
          ],
        ),
      ),
    );
  }
}
