import 'package:common/presentation/textfield/style/custom_input_decoration.dart';
import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:common/utils/date_formatter.dart';
import 'package:flutter/material.dart';

class ClockField extends StatelessWidget {
  final String? errorMessage;
  final TimeOfDay value;
  final void Function(TimeOfDay) onValueChange;
  final bool readOnly;
  const ClockField({
    super.key,
    required this.errorMessage,
    required this.value,
    required this.onValueChange,
    this.readOnly = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Jam",
          style: labelStyle,
        ),
        GestureDetector(
          onTap: () async {
            if (!readOnly) {
              final newValue = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now()
              );

              if (newValue != null) {
                onValueChange(newValue);
              }
            }
          },
          child: InputDecorator(
            decoration: CustomInputDecoration(
              errorText: errorMessage,
              suffixIcon: const Icon(Icons.access_time),
            ),
            child: Text(IntlFormatter.timeOfDayToString(value, context: context)),
          ),
        ),
      ],
    );
  }
}