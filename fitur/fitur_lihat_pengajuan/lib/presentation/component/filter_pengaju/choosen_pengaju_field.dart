import 'package:common/domain/model/pengaju.dart';
import 'package:flutter/material.dart';

class ChoosenPengajuField extends StatelessWidget {
  final Pengaju? choosenPengaju;
  final String tipePengaju;
  final void Function()? onDeletePengaju;
  const ChoosenPengajuField({
    super.key,
    required this.tipePengaju,
    required this.choosenPengaju,
    required this.onDeletePengaju,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$tipePengaju dipilih"),
        
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 106,
                  ),
                  child: Text(
                    choosenPengaju?.nama ?? '-',
                    style: const TextStyle(
                      fontSize: 11,
                    ),
                  ),
                ),

                IconButton(
                  iconSize: 16,
                  padding: const EdgeInsets.all(1),
                  onPressed: onDeletePengaju,
                  icon: choosenPengaju != null ?
                    const Icon(
                      Icons.close,
                    ) :
                    const SizedBox(),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
