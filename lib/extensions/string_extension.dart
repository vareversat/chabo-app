import 'package:chabo/const.dart';

extension StringExtension on String {
  String capitalize() {
    return isEmpty
        ? this
        : '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  bool startsWithVowel() {
    return Const.vowelList.contains(
      this[0].toLowerCase(),
    );
  }
}
