import 'package:flutter/material.dart';

class RouteStructure {
  final String name;
  final Widget Function(RouteSettings settings) builder;
  RouteStructure({
    required this.name,
    required this.builder,
  });
}