enum Month {
  januari(1),
  februari(2),
  maret(3),
  april(4),
  mei(5),
  juni(6),
  juli(7),
  agustus(8),
  september(9),
  oktober(10),
  november(11),
  desember(12);

  final int intValue;
  const Month(this.intValue);

  @override
  String toString() => 
    "${name[0].toUpperCase()}"
    "${name.substring(1)}";
}

