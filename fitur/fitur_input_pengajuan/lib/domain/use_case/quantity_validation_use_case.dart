class QuantityValidtionUseCase {
  String? call({
    required String quantityText,
    required bool isPemasukan,
    required int currentStock,
  }){
    int? quantity = int.tryParse(quantityText);
    if (quantity == null || quantity == 0){
      return "Quantity tidak valid";
    }
    if (!isPemasukan && quantity > currentStock){
      return "Quantity tidak boleh melebihi current stock";
    }
    return null;
  }
}