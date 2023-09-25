import 'package:common/domain/model/pengaju.dart';
import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/material.dart';

class ListPengajuTersedia extends StatelessWidget {
  final String tipePengaju;
  final Future<ApiResponse> getListPengajuResponse;
  final void Function() refreshListPengaju;
  final void Function(Pengaju) onChoosePengaju;

  const ListPengajuTersedia({
    super.key,
    required this.getListPengajuResponse,
    required this.refreshListPengaju,
    required this.tipePengaju,
    required this.onChoosePengaju,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$tipePengaju tersedia"),

        ApiLoader(
            apiResponse: getListPengajuResponse,
            onRefresh: refreshListPengaju,
            builder: (List<Pengaju> listPengaju) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: listPengaju.map((pengaju) {
                  return SizedBox(
                    width: double.infinity,
                    child: InkWell(
                      onTap: () {
                        onChoosePengaju(pengaju);
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Text(
                            pengaju.nama,
                            style: const TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
        ),
      ],
    );
  }
}
