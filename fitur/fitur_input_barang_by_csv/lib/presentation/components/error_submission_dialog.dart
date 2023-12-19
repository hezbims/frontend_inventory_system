import 'package:common/constant/themes/custom_font_weight.dart';
import 'package:flutter/material.dart';

class ErrorSubmissionDialog extends Dialog {
  ErrorSubmissionDialog({
    required List<MapEntry<String , List<String>>> errors,
    required super.insetPadding,
    super.key,
  }) : super(
    child:ListView.separated(
      itemBuilder: (context , index) {
        if (index == 0){
          return const Align(
            alignment: Alignment.center,
            child: Text(
              "ERROR" ,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                errors[index - 1].key,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: CustomFontWeight.medium,
                ),
              ),

              for (final error in errors[index - 1].value)
                Text("*) $error")
            ],
          ),
        );
      },
      separatorBuilder: (context , index){
        return const SizedBox(height: 24,);
      },
      itemCount: errors.length + 1,
    ),
  );
}