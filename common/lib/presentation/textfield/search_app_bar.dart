import 'package:flutter/material.dart';

class SearchAppBar extends AppBar {
  final TextEditingController controller;
  final String placeholder;
  final FocusNode focusNode;
  final Function(String)? onValueChange;
  SearchAppBar({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.focusNode,
    this.onValueChange,
    super.leading,
  }) : super(
    scrolledUnderElevation: 0,
    centerTitle: true,
    title: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
                label: Text(placeholder),
                prefixIcon: const Icon(Icons.search)
            ),
            onChanged: onValueChange,
          ),
        ),

        const SizedBox(width: 48,),
      ],
    ),
  );
}