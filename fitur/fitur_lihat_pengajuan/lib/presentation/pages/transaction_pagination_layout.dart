import 'package:common/domain/feature/transaction/model/request/get_transactions_request.dart';
import 'package:common/presentation/api_loader/default_error_widget.dart';
import 'package:common/presentation/pagination/page_event.dart';
import 'package:common/presentation/styling/color/my_colors.dart';
import 'package:common/presentation/tab_navbar/main_tab_nav_bar.dart';
import 'package:dependencies/infinite_scroll_pagination.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/transaction_item_row.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/transaction_table_header.dart';
import 'package:fitur_lihat_pengajuan/presentation/model/transaction_page_item.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/lihat_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class TransactionPaginationLayout extends StatefulWidget {
  final LihatPengajuanProvider provider;
  const TransactionPaginationLayout({
    required this.provider,
    super.key
  });

  @override
  State<TransactionPaginationLayout> createState() => _TransactionPaginationLayoutState();
}

class _TransactionPaginationLayoutState extends State<TransactionPaginationLayout> {
  final GlobalKey globalKey = GlobalKey();
  
  final pagingController = PagingController<GetTransactionsRequest, TransactionPageItem>(
      firstPageKey: GetTransactionsRequest());


  @override
  void initState() {
    pagingController.addPageRequestListener(widget.provider.fetchTransactionPage);
    widget.provider.addListener(observePagingEventCommand);
    super.initState();
  }
  
  void observePagingEventCommand(){
    final pageEvent = widget.provider.pageEvent;
    if (pageEvent == null) {
      return;
    }
    widget.provider.doneHandlingPageEvent();
    
    switch(pageEvent){
      case PageDataArrive<List<TransactionPageItem>>():
        final TransactionPageItem lastData = pageEvent.data.last;
        final nextKey = switch(lastData){
          HeaderItem() => GetTransactionsRequest(),
          DataItem() => widget.provider.request,
        };
        
        if (pageEvent.isLast) {
          pagingController.appendLastPage(pageEvent.data);
        } else {
          pagingController.appendPage(pageEvent.data, nextKey);
        }
        break;
      case PageError<List<TransactionPageItem>>():
        pagingController.error = pageEvent.message ?? "Unknown error";
        break;
      case PageRefreshRequest<List<TransactionPageItem>>():
        pagingController.refresh();
        break;
    }
  }

  @override
  void dispose() {
    widget.provider.removeListener(observePagingEventCommand);
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<GetTransactionsRequest, TransactionPageItem>(
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) =>
          switch(item){
            HeaderItem() => _buildTopMenu(
              child: const Padding(
                padding: EdgeInsets.only(top: 16),
                child: TransactionTableHeader(),
              )
            ),
            DataItem() => TransactionItemRow(
              sequence: index,
              item: item.data
            ),
          },
        firstPageProgressIndicatorBuilder: (context) =>
          _buildTopMenu(
            child: const Padding(
              padding: EdgeInsets.only(top: 48),
              child: CircularProgressIndicator(),
            ),
          ),
        firstPageErrorIndicatorBuilder: (context) =>
          _buildTopMenu(
            child: Padding(
              padding: const EdgeInsets.only(top: 48),
              child: DefaultErrorWidget(
                onTap: widget.provider.tryRefresh,
                errorMessage: pagingController.error.toString(),
              ),
            ),
          ),
      ),
    );
  }

  Widget _buildTopMenu({
    final Widget? child,
  }){
    return Column(
      children: [
        const SizedBox(height: 48,),

        const MainTabNavBar(),

        const SizedBox(height: 64,),

        Row(
          children: [
            FilledButton(
              onPressed: (){

              },
              style: FilledButton.styleFrom(
                backgroundColor: MyColors.primary3,
                padding: const EdgeInsets.all(20),
              ),
              child: const Text("Add New Transaction"),
            ),

            const SizedBox(width: 48,),

            SizedBox(
              width: 480,
              child: TextField(
                decoration: const InputDecoration(
                  label: Text("Search Transaction"),
                  hintText: "Min. 3 Character",
                  suffixIcon: Icon(Icons.search),
                ),
                key: globalKey,
                onChanged: widget.provider.setNewSearchKeyword,
              ),
            ),

            const SizedBox(width: 8,),

            IconButton(
                onPressed: (){

                },
                icon: const Icon(Icons.filter_list)
            ),

            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: widget.provider.tryRefresh,
                    icon: const Icon(Icons.refresh)
                ),
              ),
            ),
          ],
        ),
        if (child != null) child,
      ],
    );
  }
}
