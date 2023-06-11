import 'package:intl/intl.dart';

extension DateFormating on String {
  String formatDate() {
    final DateFormat formater = DateFormat('dd-mm-yyyy');
    final String formated = formater.format(DateTime.parse(this));
    return formated;
  }
}
