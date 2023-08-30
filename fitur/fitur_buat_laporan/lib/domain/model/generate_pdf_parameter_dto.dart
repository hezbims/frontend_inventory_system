import 'package:common/utils/date_formatter.dart';

class GeneratePdfParameterDto {
  final int month;
  final int year;
  GeneratePdfParameterDto({
    required this.month,
    required this.year,
  });

  String get period =>
    IntlFormatter.dateTimeToYm(DateTime(year , month));
}