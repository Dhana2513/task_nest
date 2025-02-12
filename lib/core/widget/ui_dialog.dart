import 'package:flutter/material.dart';

import '../constant/text_style.dart';
import '../extension/box_padding.dart';

class UiDialog extends StatelessWidget {
  const UiDialog({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(BoxPadding.large),
              topRight: Radius.circular(BoxPadding.large),
            ),
            color: Theme.of(context).primaryColor.withOpacity(0.9),
          ),
          padding: const EdgeInsets.only(
            left: BoxPadding.medium,
            right: BoxPadding.small,
            top: BoxPadding.small,
            bottom: BoxPadding.small,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: UITextStyle.title.copyWith(color: Colors.white),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.all(BoxPadding.small),
                  child: Icon(Icons.close, color: Colors.white),
                ),
              )
            ],
          ),
        ),
        body,
      ],
    );
  }
}
