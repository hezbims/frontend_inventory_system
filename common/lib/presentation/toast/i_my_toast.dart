abstract class IMyToast {
  void showToastNonStatic({required final String msg, final MyToastLength toastLength});
}

enum MyToastLength {
  SHORT, MEDIUM, LONG
}