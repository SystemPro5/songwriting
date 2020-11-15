// A sentence can have 0 tp  4 stars
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'sentence.g.dart';

@HiveType(typeId: 0)
class Sentence {
  @HiveField(0)
  String sentence;
  @HiveField(1)
  int stars;

  Sentence({
    @required this.sentence,
    this.stars,
  }) : assert(stars == null || (stars < 5 && stars >= 0)), assert(sentence.trim() != "");

  String toString() {
    return sentence;
  }

}