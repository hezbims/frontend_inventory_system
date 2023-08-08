class DoubleValidationUseCase {
  String? validate(String data , {
    required String fieldName
  }){
    if (double.tryParse(data) == null){
      return "$fieldName tidak valid";
    }
    else {
      return null;
    }
  }
}