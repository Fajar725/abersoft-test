import 'package:intl/intl.dart';

NumberFormat _formatter = NumberFormat.currency(locale: "id", symbol: "Rp", decimalDigits: 0);

String toRupiah({String? amount, double? doubleAmount}){

  if(amount != null) {
    double temp = double.parse(amount);
    return _formatter.format(temp);
  } else if(doubleAmount != null) {
    return _formatter.format(doubleAmount);
  }

  return _formatter.format(0);

}