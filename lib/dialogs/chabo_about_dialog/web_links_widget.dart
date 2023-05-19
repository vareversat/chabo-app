part of 'chabo_about_dialog.dart';

class _WebLinksWidget extends StatelessWidget {
  const _WebLinksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: Const.usefulLinks
              .map(
                (link) => ElevatedButton(
                  onPressed: () => link.launchURL(),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        link.iconData,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          AppLocalizations.of(context)!.selectAboutDialog(
                            link.translationKey,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
