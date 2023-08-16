import 'package:common/domain/model/kategori.dart';
import 'package:dependencies/google_fonts.dart';
import 'package:flutter/material.dart';

class KategoriCard extends StatelessWidget {
  final Kategori kategori;
  final void Function()? onTap;
  const KategoriCard({
    super.key,
    required this.kategori,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Text(
              kategori.nama,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
