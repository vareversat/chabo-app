import 'package:chabo/const.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/screens/changelog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ChaboAboutDialog extends StatelessWidget {
  final Widget _iconWidget = Padding(
    padding: const EdgeInsets.all(5),
    child: SizedBox(
      height: 60,
      width: 60,
      child: Image.asset(Const.appLogoPath),
    ),
  );

  ChaboAboutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.none &&
            snapshot.data == null) {
          return Text(AppLocalizations.of(context)!.unableAppInfo);
        }
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          titlePadding: const EdgeInsets.all(20),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          actionsPadding: const EdgeInsets.fromLTRB(0, 10, 20, 20),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconTheme(
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
                  child: _iconWidget,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Text(
                            snapshot.data!.appName,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                          ),
                          Text(
                              ' | v${snapshot.data!.version} (${snapshot.data!.buildNumber})',
                              style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                      Text(
                        Const.legalLease,
                        style:
                            Theme.of(context).textTheme.bodySmall!.copyWith(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              CustomProperties.borderRadius,
            ),
          ),
          content: ListBody(
            children: <Widget>[
              Text(
                AppLocalizations.of(context)!.appDescription,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                AppLocalizations.of(context)!.disclaimer,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontStyle: FontStyle.italic),
              ),
              const SizedBox(
                height: 15,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: Const.usefulLinks
                    .map(
                      (link) => ElevatedButton(
                        onPressed: () async => link.launchURL(),
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
              const SizedBox(
                height: 10,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 5,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.secondaryContainer),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.onSecondaryContainer),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChangeLogScreen(),
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
                          Theme.of(context).colorScheme.secondaryContainer),
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.onSecondaryContainer),
                    ),
                    onPressed: () {
                      showLicensePage(
                        context: context,
                        applicationName: snapshot.data!.appName,
                        applicationVersion:
                            'v${snapshot.data!.version}+${snapshot.data!.buildNumber}',
                        applicationIcon: _iconWidget,
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
                            AppLocalizations.of(context)!
                                .selectAboutDialog('licenses'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
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
            )
          ],
          scrollable: true,
        );
      },
      future: PackageInfo.fromPlatform(),
    );
  }
}
