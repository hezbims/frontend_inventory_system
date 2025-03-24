import 'dart:math';

import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/component/refresh_transaction_dialog.dart';
import 'package:fitur_lihat_pengajuan/presentation/pages/transaction_pagination_layout.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/filter_pengaju_provider.dart';
import 'package:fitur_lihat_pengajuan/presentation/provider/lihat_pengajuan_provider.dart';
import 'package:flutter/material.dart';

class LihatPengajuanScreen extends StatefulWidget {
  const LihatPengajuanScreen({Key? key}) : super(key: key);

  @override
  State<LihatPengajuanScreen> createState() => _LihatPengajuanScreenState();
}

class _LihatPengajuanScreenState extends State<LihatPengajuanScreen> {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GetIt.I.get<LihatPengajuanProvider>(),
        ),

        ChangeNotifierProvider(
          create: (context) => GetIt.I.get<FilterPengajuProvider>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("company name"),),
        body: Stack(
          children: [
            Builder(
              builder: (context) {
                final provider = context.read<LihatPengajuanProvider>();
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: max(MediaQuery.of(context).size.width, 1048),
                    child: TransactionPaginationLayout(provider: provider))
                );
              }
            ),

            Positioned(
              bottom: 48,
              right: 48,
              child: Consumer<LihatPengajuanProvider>(
                builder: (context, provider, child){
                  return RefreshTransactionDialog(
                    onRefresh: provider.tryRefresh,
                    isDisplayed: provider.shouldDisplayRefreshToast,
                  );
                }
              ),
            ),
          ],
        )
      )
    );
  }
}
