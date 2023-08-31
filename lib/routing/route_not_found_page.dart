import 'package:common/presentation/textfield/style/spacing.dart';
import 'package:flutter/material.dart';

class RouteNotFoundPage extends StatelessWidget {
  const RouteNotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Url atau alamat yang anda masukkan salah :'("),

            const VerticalFormSpacing(),

            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      )
    );
  }
}
