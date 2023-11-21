import 'package:flutter/material.dart';

/// Notifier untuk memberi tahu bahwa submit data pengajuan atau data barang berhasil
/// lalu memberitahu agar pagination merefresh
class RefreshNotifier extends ChangeNotifier{
  void notify() => super.notifyListeners();
}