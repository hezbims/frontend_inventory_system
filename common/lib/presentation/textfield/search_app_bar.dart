import 'package:common/constant/themes/custom_sizing.dart';
import 'package:common/presentation/constraint/constrained_width.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController controller;
  final String placeholder;
  final FocusNode focusNode;
  final Function(String)? onValueChange;
  final Function(String)? onSubmit;
  final Widget? leading;

  const SearchAppBar({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.focusNode,
    this.onValueChange,
    this.onSubmit,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: ConstrainedWidthCenter(
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                    label: Text(placeholder),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: EdgeInsets.zero,
                ),
                onChanged: onValueChange,
                onSubmitted: onSubmit,
              ),
            ),

            const SizedBox(width: 48,),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(CustomSizing.maxLayoutWidth, kToolbarHeight);
}