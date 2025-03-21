import 'package:common/domain/extension/media_query_data_extension.dart';
import 'package:dependencies/get_it.dart';
import 'package:dependencies/provider.dart';
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
        body: Builder(
          builder: (context) {
            final provider = context.read<LihatPengajuanProvider>();
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: MediaQuery.of(context).desktopPadding,
              child: SizedBox(
                width: 1000,
                child: TransactionPaginationLayout(provider: provider))
            );
          }
        )
      )
    );
  }
}
