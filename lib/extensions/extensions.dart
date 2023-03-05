extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    } else {
      return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
    }
  }
}
