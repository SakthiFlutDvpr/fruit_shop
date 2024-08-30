import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UpdateButton extends StatelessWidget {
  const UpdateButton(
      {super.key,
      required this.text,
      this.isDisable,
      this.verticalPadding,
      this.horizontalPadding,
      required this.onTap,
      this.loading});
  final String text;
  final Function() onTap;
  final bool? isDisable;
  final double? verticalPadding;
  final double? horizontalPadding;
  final bool? loading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: !isDisable! ? onTap : null,
        style: ButtonStyle(backgroundColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> state) {
          if (state.contains(WidgetState.disabled)) {
            return Colors.grey.shade300;
          }
          return Theme.of(context).colorScheme.primary;
        }), foregroundColor:
            WidgetStateProperty.resolveWith<Color>((Set<WidgetState> state) {
          if (state.contains(WidgetState.disabled)) {
            return Colors.white;
          }
          return Colors.white;
        }), textStyle: WidgetStateProperty.resolveWith<TextStyle>(
            (Set<WidgetState> state) {
          return Theme.of(context).textTheme.titleMedium!;
        }), shape: WidgetStateProperty.resolveWith<RoundedRectangleBorder>(
            (Set<WidgetState> state) {
          return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.r));
        }), padding: WidgetStateProperty.resolveWith<EdgeInsets>((state) {
          return EdgeInsets.symmetric(
              vertical: verticalPadding ?? 0,
              horizontal: horizontalPadding ?? 0);
        })),
        child: Text(text));
  }
}
