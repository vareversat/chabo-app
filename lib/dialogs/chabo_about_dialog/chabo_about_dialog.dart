import 'package:chabo/const.dart';
import 'package:chabo/custom_properties.dart';
import 'package:chabo/helpers/device_helper.dart';
import 'package:chabo/screens/changelog_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'close_button.dart';

part 'page_links_widget.dart';

part 'web_links_widget.dart';

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
    final textTheme = Theme.of(context).textTheme;

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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
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
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      Text(
                        Const.legalLease,
                        style: textTheme.bodySmall!.copyWith(),
                      ),
                    ],
                  ),
                ),
              ),
              !DeviceHelper.isPortrait(context)
                  ? const _CloseButton()
                  : const SizedBox.shrink(),
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              CustomProperties.borderRadius,
            ),
          ),
          content: Container(
            constraints: DeviceHelper.isMobile(context)
                ? DeviceHelper.isPortrait(context)
                    ? null
                    : BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width / 1.2,
                      )
                : BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width / 1.9,
                  ),
            child: DeviceHelper.isPortrait(context)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.appDescription,
                        style: textTheme.bodyLarge,
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
                      _PageLinksWidget(
                        packageInfo: snapshot.data!,
                        iconWidget: _iconWidget,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const _WebLinksWidget(),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)!.appDescription,
                              style: textTheme.bodyLarge,
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
                            _PageLinksWidget(
                              packageInfo: snapshot.data!,
                              iconWidget: _iconWidget,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                      const Flexible(
                        child: _WebLinksWidget(),
                      ),
                    ],
                  ),
          ),
          scrollable: true,
          actions:
              DeviceHelper.isPortrait(context) ? [const _CloseButton()] : [],
        );
      },
      future: PackageInfo.fromPlatform(),
    );
  }
}
