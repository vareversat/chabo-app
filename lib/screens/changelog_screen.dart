import 'package:chabo_app/const.dart';
import 'package:chabo_app/custom_widget_state.dart';
import 'package:chabo_app/screens/error_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ChangeLogScreen extends StatefulWidget {
  static const routeName = '/changelog-screen';

  const ChangeLogScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChangeLogScreenState();
  }
}

class _ChangeLogScreenState extends CustomWidgetState<ChangeLogScreen> {
  _ChangeLogScreenState() : super(screenName: 'changelog-screen');

  String _getChangelogPath(BuildContext context) {
    return Const.changelogPath.replaceAll(
      Const.changelogPlaceholder,
      Localizations.localeOf(context).languageCode,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.changelog,
        ),
      ),
      body: FutureBuilder(
        future: rootBundle.loadString(
          _getChangelogPath(context),
        ),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData) {
            return Markdown(data: snapshot.data!);
          } else if (!snapshot.hasData) {
            return ErrorScreen(
              errorMessage: snapshot.error.toString(),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
