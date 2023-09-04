import 'package:common/presentation/textfield/style/text_style.dart';
import 'package:flutter/material.dart';

class PasswordTextfield extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String? errorText;
  final FocusNode? focusNode;
  final void Function(String)? onSubmit;

  const PasswordTextfield({
    super.key,
    required this.label,
    required this.controller,
    this.errorText,
    this.focusNode,
    this.onSubmit,
  });

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final suffixIcon = Icon(
      _isPasswordVisible ?
        Icons.visibility :
        Icons.visibility_off
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label , style: labelStyle,),
        TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: InkWell(
              onTap: (){
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: suffixIcon,
            ),
            errorText: widget.errorText,
          ),
          obscureText: _isPasswordVisible ? false : true,
          enableSuggestions: false,
          autocorrect: false,
          focusNode: widget.focusNode,
          onSubmitted: widget.onSubmit,
        )
      ],
    );
  }
}
