import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:flutter/material.dart';

class PasswordTextfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPasswordVisible;
  final void Function() onChangePasswordVisibility;
  final String? errorText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmit;

  const PasswordTextfield({
    super.key,
    required this.label,
    required this.controller,
    required this.isPasswordVisible,
    required this.onChangePasswordVisibility,
    this.errorText,
    this.focusNode,
    this.textInputAction,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final suffixIcon = Icon(
      isPasswordVisible ?
        Icons.visibility :
        Icons.visibility_off
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label , style: labelStyle,),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: onChangePasswordVisibility,
              child: suffixIcon,
            ),
            errorText: errorText,
          ),
          obscureText: isPasswordVisible ? false : true,
          enableSuggestions: false,
          autocorrect: false,
          focusNode: focusNode,
          onSubmitted: onSubmit,
          textInputAction: textInputAction,
        )
      ],
    );
  }
}
