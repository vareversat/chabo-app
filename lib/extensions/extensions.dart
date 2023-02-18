import 'package:chabo/models/abstract_chaban_bridge_forecast.dart';

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    } else {
      return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
    }
  }
}

extension ListAbstractChabanBridgeForecastExtension
    on List<AbstractChabanBridgeForecast> {
  AbstractChabanBridgeForecast getNext() {
    if (this[0].circulationReOpeningDate.isBefore(DateTime.now())) {
      return this[1];
    } else {
      return this[0];
    }
  }

  List<AbstractChabanBridgeForecast> getFollowings() {
    if (this[0].circulationReOpeningDate.isBefore(DateTime.now())) {
      return sublist(2);
    } else {
      return sublist(1);
    }
  }
}
