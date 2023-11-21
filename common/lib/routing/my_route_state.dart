class MyRouteState {}

// DEPTH 1
class RouteLoginState extends MyRouteState{}
class RouteLihatStockBarangState extends MyRouteState {}
class RoutePilihTahunBulanLaporanState extends MyRouteState {}
class RouteLihatPengajuanState extends MyRouteState {}
class RouteSettingAkunState extends MyRouteState {}

// DEPTH 2
class RouteInputPengajuanState extends RouteLihatPengajuanState{
  final int? idPengajuan;
  RouteInputPengajuanState({required this.idPengajuan});
}