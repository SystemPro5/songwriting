import 'sentence.dart';

class Sentences {
  List<Sentence> _sentences = <Sentence>[];

  Sentences(List<Sentence> list, {sentences2}) : _sentences = sentences2 ?? <Sentence>[];

  void add (Sentence sentence) {
    sentences.add(sentence);
  }

  List<Sentence> get sentences => _sentences;
  // _sentences.first

 String toString() {
   return _sentences.first.sentence;
 }
}