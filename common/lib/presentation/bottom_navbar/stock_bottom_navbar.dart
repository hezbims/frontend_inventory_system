import 'package:common/constant/routes/routes_path.dart';
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
          case RoutesPath.lihatStockBarangIndex:
            nextRoute = RoutesPath.lihatStockBarangPath;
            break;
          case RoutesPath.fiturLihatPengajuanIndex:
            nextRoute = RoutesPath.lihatPengajuanPath;
            break;
          case RoutesPath.buatLaporanIndex:
            nextRoute = RoutesPath.buatLaporanPath;
            break;
          case RoutesPath.settingAkunIndex:
            nextRoute = RoutesPath.settingAkunPath;
            break;
        }

        if (nextRoute != null){
          Navigator.of(context)
            .pushNamedAndRemoveUntil(
              nextRoute, (Route<dynamic> route) => false
          );
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
