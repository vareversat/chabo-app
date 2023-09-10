import 'package:chabo_app/bloc/theme/theme_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class CustomWidgetState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  final String screenName;

  CustomWidgetState({required this.screenName});

  @override
  void initState() {
    Sentry.addBreadcrumb(
      Breadcrumb(
        message: 'Open $screenName',
        level: SentryLevel.info,
        category: 'screen.open',
        type: 'Screen',
      ),
    );
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    Sentry.addBreadcrumb(
      Breadcrumb(
        message: 'Close $screenName',
        level: SentryLevel.info,
        category: 'screen.close',
        type: 'Screen',
      ),
    );
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    BlocProvider.of<ThemeBloc>(context).add(
      AppStateChanged(),
    );
  }

  @override
  void didChangePlatformBrightness() {
    BlocProvider.of<ThemeBloc>(context).add(
      AppStateChanged(),
    );
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
