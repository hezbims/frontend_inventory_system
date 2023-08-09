import 'package:common/presentation/api_loader/api_loader.dart';
import 'package:common/response/api_response.dart';
import 'package:flutter/material.dart';

class DropDownPage<T> extends StatefulWidget {
  final Future<ApiResponse> apiResponse;
  final void Function() onRefresh;
  final Widget Function(T data) onBuildCard;
  const DropDownPage({
    super.key,
    required this.apiResponse,
    required this.onRefresh,
    required this.onBuildCard,
  });

  @override
  State<DropDownPage<T>> createState() => _DropDownPageState<T>();
}

class _DropDownPageState<T> extends State<DropDownPage<T>> {
  final searchBarController = TextEditingController();


  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: SearchBar(
          controller: searchBarController,
        ),
        leading: const BackButton(),
      ),
      body: ApiLoader<List<T>>(
        apiResponse: widget.apiResponse,
        onRefresh: widget.onRefresh,
        builder: (listData){
          return ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: 36,
              horizontal: 24,
            ),
            itemBuilder: (context , index){
              return widget.onBuildCard(listData[index]);
            },
            separatorBuilder: (context , index){
              return const SizedBox(height: 24,);
            },
            itemCount: listData.length
          );
        }
      ),
    );

  }
}
