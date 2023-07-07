part of 'chabo_about_screen.dart';

class _PageLinksWidget extends StatelessWidget {
  final PackageInfo packageInfo;
  final Widget iconWidget;

  const _PageLinksWidget({
    Key? key,
    required this.packageInfo,
    required this.iconWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              colorScheme.secondaryContainer,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              colorScheme.onSecondaryContainer,
            ),
          ),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ChangeLogScreen(),
              settings: const RouteSettings(
                name: ChangeLogScreen.routeName,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                FontAwesomeIcons.codeMerge,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.selectAboutDialog(
                    'changelog',
                  ),
                ),
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              colorScheme.secondaryContainer,
            ),
            foregroundColor: MaterialStateProperty.all<Color>(
              colorScheme.onSecondaryContainer,
            ),
          ),
          onPressed: () {
            showLicensePage(
              context: context,
              applicationName: packageInfo.appName,
              applicationVersion:
                  'v${packageInfo.version}+${packageInfo.buildNumber}',
              applicationIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconTheme(
                  data: Theme.of(context).iconTheme,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          CustomProperties.borderRadius,
                        ),
                      ),
                    ),
                    child: iconWidget,
                  ),
                ),
              ),
              applicationLegalese: Const.legalLease,
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                FontAwesomeIcons.fileLines,
                size: 20,
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.selectAboutDialog('licenses'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
