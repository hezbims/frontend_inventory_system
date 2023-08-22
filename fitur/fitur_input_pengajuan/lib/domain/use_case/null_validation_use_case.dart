class NullValidationUseCase {
  String? call(Object? data , {required String fieldName}){
    if (data == null){
      return "$fieldName tidak boleh kosong!";
    }
    return null;
  }
}