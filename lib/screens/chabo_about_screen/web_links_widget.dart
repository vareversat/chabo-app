part of 'chabo_about_screen.dart';

class _WebLinksWidget extends StatelessWidget {
  const _WebLinksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(
                CustomProperties.borderRadius / 2,
              ),
            ),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Text(
            AppLocalizations.of(context)!.externalLinks,
          ),
        ),
        Column(
          children: Const.usefulLinks
              .map(
                (link) => Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ),
                  child: ListTile(
                    dense: true,
                    onTap: () => link.launchURL(),
                    leading: Icon(
                      link.iconData,
                      size: 20,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 0),
                          child: Text(
                            AppLocalizations.of(context)!.selectAboutDialog(
                              link.translationKey,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.outbond,
                          size: 17,
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
