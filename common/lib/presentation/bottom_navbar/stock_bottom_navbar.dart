import 'package:common/constant/routes/routes.dart';
import 'package:flutter/material.dart';

class StockBottomNavBar extends StatelessWidget {
  final int _currentIndex;
  const StockBottomNavBar({
    required int currentIndex,
    super.key,
  }) : _currentIndex = currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index){
        // Kalo ngetap tempat yang sama dengan destinatin sekarang, maka enggak
        // usah lakuin apa-apa
        if (index == _currentIndex){
          return;
        }
        String? nextRoute;
        switch (index){
          case Routes.fiturLihatStockBarangIndex:
            nextRoute = Routes.fiturLihatStockBarangRoute;
            break;
          case Routes.fiturLihatPengajuanIndex:
            nextRoute = Routes.fiturLihatPengajuanRoute;
            break;
          case Routes.fiturBuatLaporanIndex:
            nextRoute = Routes.fiturBuatLaporanRoute;
            break;
          case Routes.settingAkunIndex:
            nextRoute = Routes.settingAkunRoute;
            break;
        }

        if (nextRoute != null){
          Navigator.of(context).pushReplacementNamed(nextRoute);
        }
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: "Stock Barang"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Laporan"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.swap_vert),
            label: "Transaksi"
        ),

        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Akun',
        ),
      ],
      type: BottomNavigationBarType.fixed,
    );
  }
}
