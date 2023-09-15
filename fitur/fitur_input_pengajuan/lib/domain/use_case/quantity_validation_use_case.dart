class QuantityValidtionUseCase {
  String? call({
    required String quantityText,
  }){
    int? quantity = int.tryParse(quantityText);
    if (quantity == null){
      return "Quantity tidak valid";
    }
    return null;
  }
}