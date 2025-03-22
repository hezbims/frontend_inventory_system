import 'package:common/constant/enums/status_pengajuan.dart';
import 'package:common/domain/feature/transaction/model/response/transaction_previews.dart';
import 'package:common/presentation/styling/color/my_colors.dart';
import 'package:dependencies/intl.dart';
import 'package:flutter/material.dart';

class TransactionItemRow extends StatelessWidget {
  final TransactionPreview item;
  final int sequence;
  final void Function() onClickEdit;
  const TransactionItemRow({
    required this.sequence,
    required this.item,
    required this.onClickEdit,
    super.key,
  });

  final TextStyle _smallLabelStyle = const TextStyle(
    fontSize: 14, fontWeight: FontWeight.w300);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Text(sequence.toString(), textAlign: TextAlign.center,)
          ),

          SizedBox(
            width: 100,
            child: Center(child: _buildInOrOutLabel()),
          ),

          Container(
            width: 363,
            padding: const EdgeInsets.symmetric(
              horizontal: 24, vertical: 16,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.stakeholderName,
                  style: const TextStyle(fontSize: 14),
                ),
                if (item.userName != null)
                  Text(item.userName!, style: _smallLabelStyle,),
                Text(
                  "Last update : ${_formatLastUpdate(item.lastUpdate)}",
                  style: _smallLabelStyle,
                ),
              ],
            ),
          ),

          SizedBox(
            width: 210,
            child: Text(
              item.transactionCode,
              style: const TextStyle(fontSize: 14),
            ),
          ),

          SizedBox(
            width: 154,
            child: Center(child: _buildStatusLabel()),
          ),

          SizedBox(
            width: 113,
            child: Center(
              child: FilledButton(
                onPressed: onClickEdit,
                style: FilledButton.styleFrom(
                  backgroundColor: MyColors.primary4,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)
                  ),
                ),
                child: const Text("Edit", style: TextStyle(fontWeight: FontWeight.w300),),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInOrOutLabel(){
    final String label;
    final Color color;
    if (item.isFromSupplier){
      label = "In";
      color = const Color(0xFFBFECFF);
    } else {
      label = "Out";
      color = const Color(0xFFFFBFA8);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8, vertical: 4
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(label, style: _smallLabelStyle,),
    );
  }

  Widget _buildStatusLabel(){
    final String label;
    final Color color;
    switch(item.status){
      case StatusPengajuan.menunggu:
        label = "Waiting";
        color = MyColors.warning1;
        break;
      case StatusPengajuan.diterima:
        label = "Accepted";
        color = MyColors.ok1;
        break;
      case StatusPengajuan.ditolak:
        label = "Rejected";
        color = MyColors.danger1;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(label, style: _smallLabelStyle,),
    );
  }

  String _formatLastUpdate(int lastUpdate){
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(lastUpdate);
    return DateFormat('dd-MMM-yyyy HH:mm')
        .format(dateTime);
  }
}
