import 'package:flutter/material.dart';

import '../constant/text_style.dart';
import '../extension/box_padding.dart';

class UIButton extends StatelessWidget {
  const UIButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.padding,
  });

  final VoidCallback onPressed;
  final String title;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(BoxPadding.medium),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          title,
          style: UITextStyle.subtitle1.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
