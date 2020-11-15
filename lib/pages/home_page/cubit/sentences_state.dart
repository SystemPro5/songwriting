part of 'sentences_cubit.dart';

abstract class SentencesState extends Equatable {
  const SentencesState();
}

class SentencesInitial extends SentencesState {
  final List<Sentence> sentences = const <Sentence>[];
  final bool isSentenceGeneratorOn = false;
  const SentencesInitial();

  // @override
  // void initState() {
  //   print('state = SentencesInitial');
  // }

  @override
  List<Object> get props => [SentencesInitial()];
}

class SentencesLoading extends SentencesState {
  const SentencesLoading();

  @override
  List<Object> get props => [];
}

class SentencesLoaded extends SentencesState {
  final List<Sentence> sentences;
  final bool isSentenceGeneratorOn;

  const SentencesLoaded(
      {@required this.sentences, @required this.isSentenceGeneratorOn}) : assert(sentences != null, 'sentences == null'), assert(isSentenceGeneratorOn != null,'isSentenceGenerator == null');


  @override
  List<Object> get props =>
      [DateTime.now(), sentences, isSentenceGeneratorOn];
}

// class SentenceGenerator extends SentencesLoaded {}
// class SentenceGeneratorSwitched extends SentencesState {
//   final bool sentenceGeneratorOn;
//
//   const SentenceGeneratorSwitched({@required this.sentenceGeneratorOn});
//
//   @override
//   List<Object> get props => [sentenceGeneratorOn];
// }
