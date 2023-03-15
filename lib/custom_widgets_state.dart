import 'package:chabo/bloc/theme/theme_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomWidgetState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
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
