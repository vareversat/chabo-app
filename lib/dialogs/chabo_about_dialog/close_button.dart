part of 'chabo_about_dialog.dart';

class _CloseButton extends StatelessWidget {
  const _CloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        foregroundColor: MaterialStateProperty.all<Color>(
          Theme.of(context).primaryColor,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              CustomProperties.borderRadius,
            ),
          ),
        ),
      ),
      onPressed: () => {Navigator.pop(context)},
      icon: const Icon(Icons.close),
      label: Text(
        MaterialLocalizations.of(context).closeButtonLabel,
      ),
    );
  }
}
