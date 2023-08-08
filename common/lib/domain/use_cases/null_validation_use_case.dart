class NullValidationUseCase {
  String? validate(Object? data , {
    required String fieldName
  }){
    if (data == null){
      return "$fieldName tidak boleh kosong";
    }
    else {
      return null;
    }
  }
}