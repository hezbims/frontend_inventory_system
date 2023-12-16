import 'package:common/constant/themes/custom_sizing.dart';
import 'package:common/presentation/constraint/constrained_width.dart';
import 'package:flutter/material.dart';

class SearchWithFilterAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String label;
  final String? hintText;
  final void Function(BuildContext) onFilterPressed;
  final void Function(String) onValueChange;
  final TextEditingController searchController;

  const SearchWithFilterAppBar({
    required this.label,
    required this.onFilterPressed,
    required this.searchController,
    required this.onValueChange,
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedWidthCenter(
      child: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            label: Text(label),
            hintText: hintText,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: onValueChange,
        ),
        actions: [
          IconButton(
            onPressed: () => onFilterPressed(context),
            icon: const Icon(Icons.filter_alt , size: 32,)
          ),

          const SizedBox(width: 16,),
        ],
        scrolledUnderElevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => const Size(CustomSizing.maxPhoneLandscapeWidth, kToolbarHeight);
  
}