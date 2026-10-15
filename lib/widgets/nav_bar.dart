// 1. Events
import 'package:chabo_app/bloc/status/status_bloc.dart';
import 'package:chabo_app/l10n/app_localizations.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class NavEvent {}

class NavIndexChanged extends NavEvent {
  final int index;

  NavIndexChanged(this.index);
}

class NavState {
  final int currentIndex;

  NavState(this.currentIndex);
}

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavState(0)) {
    on<NavIndexChanged>((event, emit) {
      emit(NavState(event.index));
    });
  }
}

// 4. Widget
class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const NavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        NavigationDestination(
          icon:
              context.watch<StatusBloc>().state.bridgeState == BridgeState.open
              ? FaIcon(FontAwesomeIcons.bridgeCircleCheck)
              : context.watch<StatusBloc>().state.bridgeState ==
                    BridgeState.willSoonClose
              ? FaIcon(FontAwesomeIcons.bridgeCircleExclamation)
              : FaIcon(FontAwesomeIcons.bridgeCircleXmark),
          label: AppLocalizations.of(context)!.status,
        ),
        NavigationDestination(
          icon: Icon(Icons.list),
          selectedIcon: Icon(Icons.list_alt),
          label: AppLocalizations.of(context)!.schedules,
        ),
        NavigationDestination(
          icon: const Icon(Icons.notifications_none),
          selectedIcon: const Icon(Icons.notifications_active),
          label: AppLocalizations.of(context)!.notifications,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings),
          label: AppLocalizations.of(context)!.openSetting,
        ),
      ],
    );
  }
}
