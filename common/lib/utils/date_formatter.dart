import 'package:dependencies/intl.dart';
import 'package:flutter/material.dart';

abstract class IntlFormatter {
  static final _dateFormatter = DateFormat.yMMMd();
  static String dateTimeToString(DateTime value){
    return _dateFormatter.format(value);
  }
  static  DateTime stringToDateTime(String value){
    return _dateFormatter.parse(value);
  }

  static final _timeFormatter = DateFormat.Hm();
  static String timeOfDayToString(
    TimeOfDay value,
    {required BuildContext context}
  ){
    final hour = value.hour.toString().padLeft(2 , "0");
    final minute = value.minute.toString().padLeft(2 , "0");
    return "$hour:$minute";
  }

  static TimeOfDay stringToTimeOfDay(String value){
    return TimeOfDay.fromDateTime(_timeFormatter.parse(value));
  }
}