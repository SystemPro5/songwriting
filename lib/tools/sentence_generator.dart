import 'dart:math';
import 'package:songwriting01/data/sentence_vocabulary.dart';
import 'package:songwriting01/models/sentence.dart';


abstract class BaseSentenceHandler {
  /// Throws [NetworkException].
  Sentence createSentence();
  // List<Sentence> loadInitialSentences();
}

class SentenceGenerator implements BaseSentenceHandler {
  String nextVal(a) {
    Random random = Random();
    int randomNumber =
        random.nextInt(a.length); // from 0 up to the length of list a
    return a[randomNumber];
  }

  //The initial sentences that will be on the screen are the sentences at
  //the time the application was closed

  // List<Sentence> loadInitialSentences() {
  //   //final List<Sentence> _sentences = [Sentence(sentence: 'She has crossed the fury of the warrior'), Sentence(sentence: "Even the dawn may seperate")];
  //   //print('sentence_handler/loadInitialSentences - _sentences = _sentences');
  //   final List<Sentence> _sentences = [];
  //   return _sentences;
  // }

  Sentence createSentence() {
    // Simulate network delay
    // return Future.delayed(
    //   Duration(seconds: 1),
    //   () {
    var mySent = nextVal(sent);
    var output = "";
    Sentence sentence;
    for (var i = 0; i < mySent.length; i++) {
      if (mySent[i] == '@') {
        i++;
        switch (mySent[i]) {
          case 'a':
            output += nextVal(adj);
            break;
          case 's':
            output += nextVal(est);
            break;
          case 'n':
            output += nextVal(noun);
            break;
          case 'c':
            output += nextVal(cons);
            break;
          case 'p':
            output += nextVal(pers);
            break;
          case 'v':
            output += nextVal(verb);
            break;
          case 'i':
            output += nextVal(verbing);
            break;
          case 'd':
            output += nextVal(verbed);
            break;
          case 'y':
            output += nextVal(adv);
            break;
        }
      } else {
        output += mySent[i];
      }
    }
    output = output.substring(0, 1).toUpperCase() + output.substring(1);
    return Sentence(sentence: output);
  }

  Stream<Sentence> sentenceStream() {
    return Stream.periodic(Duration(seconds: 1), (_) => createSentence());
  }

// );
  // }
}
