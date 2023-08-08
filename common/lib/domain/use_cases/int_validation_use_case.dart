class IntValidationUseCase {
  String? validate(String data , {
    required String fieldName
  }){
    if (int.tryParse(data) == null){
      return "$fieldName tidak valid";
    }
    else {
      return null;
    }
  }
}