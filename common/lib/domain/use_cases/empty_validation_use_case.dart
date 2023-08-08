class EmptyValidationUseCase {
  String? validate(String data , {
    required String fieldName
  }){
    if (data.isEmpty){
      return "$fieldName tidak boleh kosong";
    }
    else {
      return null;
    }
  }
}