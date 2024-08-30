import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    this.controller,
    this.filled,
    this.border,
    this.hintText,
    this.validator,
    this.onSaved,
    this.inputType,
    this.focusNode,
  });
  final TextEditingController? controller;
  final TextInputType? inputType;
  final bool? filled;

  final bool? border;
  final String? hintText;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      onSaved: onSaved,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(color: const Color(0xff444444)),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: const Color(0xff999999)),
          border: border!
              ? OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0xff666666),
                  ),
                  borderRadius: BorderRadius.circular(8.r))
              : InputBorder.none,
          enabledBorder: border!
              ? OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1,
                    color: Color(0xff666666),
                  ),
                  borderRadius: BorderRadius.circular(8.r))
              : InputBorder.none,
          focusedBorder: border!
              ? OutlineInputBorder(
                  borderSide: const BorderSide(
                    width: 1.5,
                    color: Color(0xff444444),
                  ),
                  borderRadius: BorderRadius.circular(8.r))
              : InputBorder.none,
          errorStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: const Color(0xffE54444)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.5,
                color: Color(0xffE54444),
              ),
              borderRadius: BorderRadius.circular(8.r)),
          filled: filled,
          fillColor: filled! ? Colors.grey.shade400 : Colors.transparent),
    );
  }
}
