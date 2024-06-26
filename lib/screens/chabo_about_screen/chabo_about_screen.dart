import 'package:chabo_app/const.dart';
import 'package:chabo_app/cubits/floating_actions_cubit.dart';
import 'package:chabo_app/custom_properties.dart';
import 'package:chabo_app/extensions/color_scheme_extension.dart';
import 'package:chabo_app/helpers/device_helper.dart';
import 'package:chabo_app/misc/no_scaling_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

part 'page_links_widget.dart';
part 'store_rate_widget.dart';
part 'web_links_widget.dart';

class ChaboAboutScreen extends StatelessWidget {
  static const routeName = '/about-screen';

  final Widget _iconWidget = Padding(
    padding: const EdgeInsets.all(5),
    child: SizedBox(
      height: 80,
      width: 80,
      child: Image.asset(Const.appLogoPath),
    ),
  );

  ChaboAboutScreen({super.key});

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

    return BlocBuilder<FloatingActionsCubit, FloatingActionsState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            heroTag: null,
            onPressed: () {
              Navigator.of(context).pop();
            },
            label: Wrap(
              spacing: 10,
              children: [
                Text(
                  MaterialLocalizations.of(context).closeButtonLabel,
                ),
                const Icon(Icons.close),
              ],
            ),
          ),
          floatingActionButtonLocation: state.isRightHanded
              ? FloatingActionButtonLocation.endFloat
              : FloatingActionButtonLocation.startFloat,
          floatingActionButtonAnimator: NoScalingAnimation(),
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            leading: const Icon(Icons.info_outline),
            title: Text(
              AppLocalizations.of(context)!.about,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
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
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(
                          CustomProperties.borderRadius * 2,
                        ),
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
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Text(
                                                snapshot.data!.appName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                            style:
                                                textTheme.bodySmall!.copyWith(),
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
                                      iconWidget: _iconWidget,
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
                                          MediaQuery.of(context).size.width /
                                              1.2,
                                    )
                              : BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width / 1.9,
                                ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!
                                          .appDescription,
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
                                          ?.copyWith(
                                            fontStyle: FontStyle.italic,
                                          ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    DeviceHelper.isPortrait(context)
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 35.0,
                                            ),
                                            child: _PageLinksWidget(
                                              packageInfo: snapshot.data!,
                                              iconWidget: _iconWidget,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
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
      },
    );
  }
}
