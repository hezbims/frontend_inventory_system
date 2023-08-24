import 'package:flutter/material.dart';

class SearchWithFilterAppBar extends AppBar {
  final String label;
  final String? hintText;
  final void Function() onFilterPressed;
  final void Function(String) onValueChange;
  final TextEditingController searchController;

  SearchWithFilterAppBar({
    required this.label,
    required this.onFilterPressed,
    required this.searchController,
    required this.onValueChange,
    this.hintText,
    super.key,
  }) : super(
    title: Padding(
      padding: const EdgeInsets.only(
          left: 16,
          top: 8,
          bottom: 8
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          label: Text(label),
          hintText: hintText,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: onValueChange,
      ),
    ),
    actions: [
      IconButton(
        onPressed: onFilterPressed,
        icon: const Icon(Icons.filter_alt , size: 32,)
      ),

      const SizedBox(width: 16,),
    ],
    scrolledUnderElevation: 0,
  );
}