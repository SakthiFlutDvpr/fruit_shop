import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension PaddingExtensins on BuildContext {
  EdgeInsets padding() =>
      EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h);
  EdgeInsets horizontalPadding() => EdgeInsets.symmetric(horizontal: 16.w);
  EdgeInsets verticalPadding() => EdgeInsets.symmetric(vertical: 20.h);
}

// extension StringExtensions on String {
//   String capitalise() {
//     return (this).toString().split(' ').map((e) {
//       if (e.isEmpty) return e;
//       return e[0].toUpperCase() + e.substring(1).toLowerCase();
//     }).join(' ');
//   }
// }
