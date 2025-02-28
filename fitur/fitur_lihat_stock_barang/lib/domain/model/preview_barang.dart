class PreviewBarang {
  final int id;
  final String name;
  final String location;
  final String quantity;
  final BarangStockStatus status;
  PreviewBarang({
    required this.id,
    required this.name,
    required this.location,
    required this.quantity,
    required this.status,
  });
}

enum BarangStockStatus {
  shortage, runOut, ok;
}