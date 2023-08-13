import 'package:common/domain/model/group.dart';
import 'package:common/themes/custom_font_weight.dart';
import 'package:dependencies/google_fonts.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final Group group;
  const GroupCard({
    super.key,
    required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: (){
        Navigator.of(context).pop(group);
      },
      child: Card(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(group.namaGroup),
              Text(
                "Section : AIDA",
                style: GoogleFonts.inter(
                  fontWeight: CustomFontWeight.light,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
