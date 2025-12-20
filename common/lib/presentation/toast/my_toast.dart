import 'package:common/domain/model/common_domain_error.dart';
import 'package:dependencies/fluttertoast.dart';
import 'package:flutter/material.dart';

abstract class MyToast {
  static void showToast({required final String msg, final MyToastLength toastLength = MyToastLength.MEDIUM}) =>
      Fluttertoast.showToast(
        msg: msg,
        webBgColor: "#000000dd",
        backgroundColor: Colors.black,
        textColor: Colors.white,
        toastLength: switch(toastLength){
          MyToastLength.SHORT => Toast.LENGTH_SHORT,
          MyToastLength.MEDIUM => Toast.LENGTH_LONG,
          MyToastLength.LONG => Toast.LENGTH_LONG,
        },
        timeInSecForIosWeb: switch(toastLength){
          MyToastLength.SHORT => 1,
          MyToastLength.MEDIUM => 3,
          MyToastLength.LONG => 5,
        },
      );

  static void handleCommonDomainError(CommonDomainError error){
    final message = switch(error){
      NotReachedError() => "Network error occured. Try again later.",
      UnknownAppError() => "Unknown error occured.",
    };

    showToast(msg: message);
  }
}

enum MyToastLength {
  SHORT, MEDIUM, LONG
}