import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:flutter/material.dart';

class PasswordTextfield extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPasswordVisible;
  final void Function() onChangePasswordVisibility;
  final String? errorText;
  final FocusNode? focusNode;

  const PasswordTextfield({
    super.key,
    required this.label,
    required this.controller,
    required this.isPasswordVisible,
    required this.onChangePasswordVisibility,
    this.errorText,
    this.focusNode,
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
          ),
          obscureText: isPasswordVisible ? false : true,
          enableSuggestions: false,
          autocorrect: false,
          focusNode: focusNode,
        )
      ],
    );
  }
}
