import 'package:flutter/material.dart';

import '../constant/text_style.dart';
import '../extension/box_padding.dart';

class UiTextField extends StatelessWidget {
  const UiTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(BoxPadding.small),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        border: const OutlineInputBorder(),
        hintText: hintText,
        labelText: hintText,
        hintStyle: UITextStyle.subtitle1.copyWith(color: Colors.black54),
      ),
      keyboardType: keyboardType,
      textCapitalization: TextCapitalization.sentences,
    );
  }
}
