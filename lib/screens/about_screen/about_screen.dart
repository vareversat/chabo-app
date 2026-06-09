import 'package:chabo_app/const.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/extensions/color_scheme_extension.dart';
import 'package:chabo_app/helpers/device_helper.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'page_links_widget.dart';

part 'store_rate_widget.dart';

part 'web_links_widget.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about-screen';

  const AboutScreen({super.key});

  String _formatBetaVersion(String versionCode) {
    if (versionCode.contains('beta')) {
      return "${versionCode.split('-')[0]}-β";
    } else {
      return versionCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final Widget iconWidget = Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        height: 80,
        width: 80,
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.onSurface,
            BlendMode.srcIn,
          ),
          child: Image.asset(Const.appLogoPath),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyActions: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: FutureBuilder<PackageInfo>(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.connectionState == ConnectionState.none &&
              snapshot.data == null) {
            return Text(AppLocalizations.of(context)!.unableAppInfo);
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                snap: false,
                stretch: true,
                collapsedHeight: 120,
                expandedHeight: 150,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(CustomProperties.borderRadius * 2),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  expandedTitleScale: 1,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Flexible(
                          child: IconTheme(
                            data: Theme.of(context).iconTheme,
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(
                                        CustomProperties.borderRadius,
                                      ),
                                    ),
                                  ),
                                  child: iconWidget,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            ' | ${_formatBetaVersion(snapshot.data!.version)} (${snapshot.data!.buildNumber})',
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
                              ],
                            ),
                          ),
                        ),
                        DeviceHelper.isPortrait(context)
                            ? const SizedBox.shrink()
                            : Flexible(
                                child: _PageLinksWidget(
                                  packageInfo: snapshot.data!,
                                  iconWidget: iconWidget,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      constraints: DeviceHelper.isMobile(context)
                          ? DeviceHelper.isPortrait(context)
                                ? null
                                : BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 1.2,
                                  )
                          : BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 1.9,
                            ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.appDescription,
                                  style: textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  AppLocalizations.of(context)!.disclaimer,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontStyle: FontStyle.italic),
                                ),
                                const SizedBox(height: 15),
                                DeviceHelper.isPortrait(context)
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 35.0,
                                        ),
                                        child: _PageLinksWidget(
                                          packageInfo: snapshot.data!,
                                          iconWidget: iconWidget,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 80.0),
                            child: _WebLinksWidget(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        future: PackageInfo.fromPlatform(),
      ),
    );
  }
}
