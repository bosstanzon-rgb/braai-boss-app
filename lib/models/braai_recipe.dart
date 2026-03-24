import 'package:flutter/foundation.dart';

@immutable
class BraaiRecipe {
  const BraaiRecipe({
    required this.id,
    required this.nameEn,
    required this.nameAf,
    required this.descriptionEn,
    required this.descriptionAf,
    required this.minutes,
    required this.heatLevel,
    required this.tags,
    required this.tipsEn,
    required this.tipsAf,
  });

  final String id;
  final String nameEn;
  final String nameAf;
  final String descriptionEn;
  final String descriptionAf;
  final int minutes;
  final BraaiHeatLevel heatLevel;
  final List<String> tags;
  final List<String> tipsEn;
  final List<String> tipsAf;
}

enum BraaiHeatLevel {
  low,
  medium,
  high,
}

