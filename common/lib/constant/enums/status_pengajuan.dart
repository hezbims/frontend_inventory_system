import 'package:common/constant/themes/status_colors.dart';
import 'package:flutter/material.dart';

enum StatusPengajuan {
  menunggu,
  diterima,
  ditolak;

  factory StatusPengajuan.from(String str){
    switch (str){
      case 'menunggu':
        return menunggu;
      case 'diterima':
        return diterima;
      case 'ditolak':
        return ditolak;
      default:
        throw FormatException("Value $str tidak ditemukan dalam enum status pengajuan");
    }
  }

  Color getTextColor(){
    switch (this){
      case StatusPengajuan.diterima:
        return diterimaStatusTextColor;
      case StatusPengajuan.menunggu:
        return menungguStatusTextColor;
      case StatusPengajuan.ditolak:
        return ditolakStatusTextColor;
    }
  }

  Color getContainerColor(){
    switch (this){
      case StatusPengajuan.diterima:
        return diterimaStatusContainerColor;
      case StatusPengajuan.menunggu:
        return menungguStatusContainerColor;
      case StatusPengajuan.ditolak:
        return ditolakStatusContainerColor;
    }
  }
}