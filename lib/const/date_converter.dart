import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart' as intl_local_date_data;

String dateToStringHoursMinutesSeconds(DateTime date) {
  intl_local_date_data.initializeDateFormatting('id');
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
}

DateTime stringToDateHoursMinutesSeconds(String date) {
  intl_local_date_data.initializeDateFormatting('id');
  return DateFormat('yyyy-MM-dd HH:mm:ss').parse(date);
}

DateTime stringToDateLocalHoursMinutesSeconds(String date) {
  intl_local_date_data.initializeDateFormatting('id');
  return DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date);
}

String dateToStringSimple(DateTime date) {
  intl_local_date_data.initializeDateFormatting('id');
  return DateFormat('dd MMM yyyy', 'id').format(date);
}

String dateToStringSimple2(DateTime date) {
  intl_local_date_data.initializeDateFormatting('id');
  return DateFormat('dd MMMM yyyy', 'id').format(date);
}

DateTime stringToDateOnlyDate(String date) {
  intl_local_date_data.initializeDateFormatting('id');
  return DateFormat('yyyy-MM-dd').parse(date);
}

String dateToStringOnlyDate(DateTime date) {
  intl_local_date_data.initializeDateFormatting('id');
  return DateFormat('yyyy-MM-dd').format(date);
}

String dateToStringOnlyTime(DateTime date) {
  intl_local_date_data.initializeDateFormatting('id');
  return DateFormat('HH:mm:ss').format(date);
}

String dateToString(DateTime date) {
  intl_local_date_data.initializeDateFormatting('id');
  return DateFormat('dd MMMM yyyy HH:mm', 'id').format(date);
}

String dateToStringSimpleWithTime(DateTime date) {
  intl_local_date_data.initializeDateFormatting('id');
  return DateFormat('dd MMM yyyy HH:mm', 'id').format(date);
}

String dateToStringNoSeperator(DateTime date) {
  intl_local_date_data.initializeDateFormatting('id');
  return DateFormat('ddMMyyyyHHmmss', 'id').format(date);
}