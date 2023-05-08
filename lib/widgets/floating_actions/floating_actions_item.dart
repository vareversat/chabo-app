import 'package:flutter/material.dart';

class FloatingActionsItem extends StatelessWidget {
  final bool isSpaced;
  final List<Widget> content;
  final bool isRightHanded;
  final Function() onPressed;

  const FloatingActionsItem({
    Key? key,
    required this.isRightHanded,
    required this.onPressed,
    required this.content,
    required this.isSpaced,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      heroTag: null,
      onPressed: onPressed,
      label: Wrap(
        spacing: isSpaced ? 10 : 0,
        children: isRightHanded ? content : content.reversed.toList(),
      ),
    );
  }
}
