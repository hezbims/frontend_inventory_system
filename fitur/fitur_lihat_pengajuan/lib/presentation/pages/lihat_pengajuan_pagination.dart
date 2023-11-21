import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/presentation/provider/refresh_notifier.dart';
import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:common/routing/my_route_state.dart';
import 'package:common/routing/my_route_state_provider.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/domain/model/pengajuan_preview.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/pengajuan_card.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/lihat_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class LihatPengajuanPagination extends StatefulWidget {
  final LihatPengajuanProvider provider;
  const LihatPengajuanPagination({
    required this.provider,
    super.key
  });

  @override
  State<LihatPengajuanPagination> createState() => _LihatPengajuanPaginationState();
}

class _LihatPengajuanPaginationState extends State<LihatPengajuanPagination> {
  late final refreshNotifier = context.read<RefreshNotifier>();
  late final routeStateProvider = context.read<MyRouteStateProvider>();
  @override
  Widget build(BuildContext context) {
    return PagedListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).phoneLandscapePadding,
        vertical: 24,
      ),
      pagingController: widget.provider.pagingController,
      builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context , PengajuanPreview pengajuan , index){
            return PengajuanCard(
              pengajuan: pengajuan,
              onTap: () async {
                routeStateProvider.setRouteState(
                    RouteInputPengajuanState(idPengajuan: pengajuan.id)
                );
              },
            );
          },
          firstPageErrorIndicatorBuilder: (context){
            return DefaultErrorWidget(
              onTap: widget.provider.tryRefresh,
              errorMessage: widget.provider.pagingController.error.toString(),
            );
          }
      ),
      separatorBuilder: (context , index){
        return const VerticalFormSpacing();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    refreshNotifier.addListener(widget.provider.tryRefresh);
  }

  @override
  void dispose() {
    refreshNotifier.removeListener(widget.provider.tryRefresh);
    super.dispose();
  }


}
