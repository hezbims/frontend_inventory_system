enum Month {
  january(1),
  february(2),
  march(3),
  april(4),
  may(5),
  june(6),
  july(7),
  august(8),
  september(9),
  october(10),
  november(11),
  december(12);

  final int intValue;
  const Month(this.intValue);

  @override
  String toString() => 
    "${name[0].toUpperCase()}"
    "${name.substring(1)}";
}

