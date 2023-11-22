class MyRouteState {}

// DEPTH 1
class RouteLihatStockBarangState extends MyRouteState {}
class RoutePilihTahunBulanLaporanState extends MyRouteState {}
class RouteLihatPengajuanState extends MyRouteState {}
class RouteSettingAkunState extends MyRouteState {}

// DEPTH 2
class RouteInputPengajuanState extends RouteLihatPengajuanState{
  final int? idPengajuan;
  RouteInputPengajuanState({required this.idPengajuan});
}
class RouteInputFormDataBarangState extends RouteLihatStockBarangState{
  final int? idBarang;
  RouteInputFormDataBarangState({required this.idBarang});
}
class RouteInputBarangByCsvState extends RouteLihatStockBarangState{}
class RoutePreviewLaporanState extends RoutePilihTahunBulanLaporanState{
  final int tahun;
  final int bulan;
  RoutePreviewLaporanState({
    required this.bulan, required this.tahun,
  });
}