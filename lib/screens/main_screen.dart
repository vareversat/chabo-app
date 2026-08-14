import 'package:chabo_app/screens/forecast_screen.dart';
import 'package:chabo_app/screens/notification_screen/notification_screen.dart';
import 'package:chabo_app/screens/setting_screen.dart';
import 'package:chabo_app/screens/status_screen/status_screen.dart';
import 'package:chabo_app/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavBloc, NavState>(
        builder: (context, state) {
          return NavBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<NavBloc>().add(NavIndexChanged(index));
            },
          );
        },
      ),
      body: BlocBuilder<NavBloc, NavState>(
        builder: (context, state) {
          return IndexedStack(
            index: state.currentIndex,
            children: [
              StatusScreen(),
              ForecastScreen(),
              NotificationScreen(),
              SettingScreen(),
            ],
          );
        },
      ),
    );
  }
}
