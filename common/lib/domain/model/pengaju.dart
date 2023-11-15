class Pengaju {
  final String nama;
  final bool isPemasok;
  final int id;

  Pengaju({
    required this.nama,
    required this.id,
    required this.isPemasok,
  });

  @override
  String toString() => nama;
}