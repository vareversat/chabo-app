import 'package:chabo_app/custom_properties.dart';
import 'package:material_ui/material_ui.dart';

class SimpleContainer extends StatelessWidget {
  final Widget child;

  const SimpleContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(CustomProperties.borderRadius),
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
      ),
      child: child,
    );
  }
}
