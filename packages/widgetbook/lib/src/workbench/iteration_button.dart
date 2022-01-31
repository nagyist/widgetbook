import 'package:flutter/material.dart';
import 'package:widgetbook/src/utils/extensions.dart';
import 'package:widgetbook/src/workbench/workbench_button.dart';

class IterationButton extends StatelessWidget {
  const IterationButton._({
    Key? key,
    required this.onPressed,
    required this.iconData,
  }) : super(key: key);

  factory IterationButton.left({
    required VoidCallback onPressed,
  }) {
    return IterationButton._(
      onPressed: onPressed,
      iconData: Icons.chevron_left,
    );
  }

  factory IterationButton.right({
    required VoidCallback onPressed,
  }) {
    return IterationButton._(
      onPressed: onPressed,
      iconData: Icons.chevron_right,
    );
  }

  final VoidCallback onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return WorkbenchButton.icon(
      onPressed: onPressed,
      child: Icon(
        iconData,
        color: context.theme.hintColor,
      ),
    );
  }
}
