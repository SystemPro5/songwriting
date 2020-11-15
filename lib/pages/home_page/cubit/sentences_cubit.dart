import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:songwriting01/models/sentence.dart';
import 'package:songwriting01/tools/sentence_generator.dart';
import 'package:songwriting01/tools/tts_player.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

part 'sentences_state.dart';

class SentencesCubit extends Cubit<SentencesState> {
  final _sentenceGenerator; //_sentenceGenerator;
  List<Sentence> _sentences;
  bool _isSentenceGeneratorOn = false;
  bool _isSpeechOn = true;
  Timer _timer;
  TtsPlayer ttsPlayer = TtsPlayer();
  int _sentenceSeperationTime = 1;

  SentencesCubit()
      : _sentenceGenerator = SentenceGenerator(),
        // initTts(),
        super(SentencesInitial());

  //Loads sentences from the hive database when the app is started
  // Future<void> loadSentences() async {
  void initialiseCubit() async {
    try {
      //Initialising the player will execute events when the player has stopped,
      //paused, is playing, ...
      ttsPlayer.initTts();
      //_sentences = _sentenceHandler.loadInitialSentences();
      _sentences = [];
      print(
          'sentences_cubit/initialiseCubit - _sentences.isempty = ${_sentences.isEmpty}');
      //the next sentence was necessary to get/view the emitted state "SentencesLoaded" in the receiving widget (here home_page)
      await Future<void>.delayed(const Duration(milliseconds: 50));
      emit(SentencesLoaded(
          sentences: _sentences,
          isSentenceGeneratorOn: _isSentenceGeneratorOn));
    } catch (e) {
      print('sentences_cubit/initialiseCubit - cannot load sentences');
      print('error = $e');
    }
    // on NetworkException {
    //   emit(WeatherError("Couldn't fetch weather. Is the device online?"));
    // }
  }

  void setSentenceGeneratorOn() async {
    _isSentenceGeneratorOn = true;
    await Future<void>.delayed(const Duration(milliseconds: 50));
    emit(SentencesLoaded(
        sentences: _sentences, isSentenceGeneratorOn: _isSentenceGeneratorOn));
    sentenceGenerator();
    //sentenceGenerator();
  }

  void setSentenceGeneratorOff() async {
    _isSentenceGeneratorOn = false;
    _timer?.cancel();
    await Future<void>.delayed(const Duration(milliseconds: 50));
    emit(SentencesLoaded(
        sentences: _sentences, isSentenceGeneratorOn: _isSentenceGeneratorOn));
  }

  void sentenceGenerator() async {
    List<String> words;
    Sentence _sentence;
    String _partialSentence;
    while (_isSentenceGeneratorOn) {
      _sentence = await _sentenceGenerator.createSentence();
      _sentences.insert(0, _sentence);
      //Keep a list of 20 sentences in the UI
      if (_sentences.length == 21) _sentences.removeAt(20);

      // if (!_isSpeechOn) {
      print(
          'sentences_cubit/sentenceGenerator - ttsPlayer.isStopped = ${ttsPlayer.isStopped}');

      print('sentences_cubit/sentenceGenerator - Stopped ');

      emit(SentencesLoaded(
          sentences: _sentences,
          isSentenceGeneratorOn: _isSentenceGeneratorOn));

      await ttsPlayer.speak(text: _sentences[0].sentence);
      _sentenceSeperationTime = Settings.getValue('key-slider-sentence-seperation-time', 1.0).toInt();
      await Future.delayed(Duration(seconds: _sentenceSeperationTime));

      //print('sentences_cubit/sentenceGenerator - app-settings - wait = $_sentenceSeperationTime');
      // }

      // else {
      //   //speech is on
      //   print(
      //       'sentences_cubit/sentenceGenerator - ttsPlayer.state = ${ttsPlayer.state}');
      //   print('sentences_cubit/sentenceGenerator - Stopped ');
      //
      //   words = _sentence.sentence.split(' ');
      //
      //   for (String word in words) {
      //     print(
      //         'sentences_cubit/sentenceGenerator - ttsPlayer.state = ${ttsPlayer.state}');
      //     // if (ttsPlayer.isStopped) {
      //     if (word == words.first) {
      //       _partialSentence = word;
      //     } else {
      //       _partialSentence = _partialSentence + ' ' + word;
      //     }
      //
      //
      //     print(
      //         'sentences_cubit/sentenceGenerator - _partialSentence = $_partialSentence ');
      //
      //     _sentences[0].sentence = _partialSentence;
      //     //Future.delayed(Duration(milliseconds: 50));
      //     emit(SentencesLoaded(
      //         sentences: _sentences,
      //         isSentenceGeneratorOn: _isSentenceGeneratorOn));
      //     await ttsPlayer.speak(text:  _sentences[0].sentence);
      //
      //
      //   }
      //   await Future.delayed(Duration(seconds: 2));
      //
      // }
    }
  }

  // Future speak({@required String text, bool synchroniseTextAndSpeech}) async {
  //   List<String> words = text.split(' ');
  //   for (String word in words) {
  //     await ttsPlayer.speak(text: word);
  //   }
  // }

  void setSentenceFavorite({@required int index}) {
    var _sentenceBox = Hive.box('p2');
    if (_sentences[index].stars == null) {
      _sentences[index].stars = 0;
      //Add the sentence to the database (hive-db)
      _sentenceBox.add(_sentences[index]);
    }
    // else {
    //   _sentences[index].stars = null;
    //   var _sentence = _sentenceBox.get(_sentences[index]);
    //   _sentenceBox.delete(_sentences[index]);
    // }

    emit(SentencesLoaded(
        sentences: _sentences, isSentenceGeneratorOn: _isSentenceGeneratorOn));
  }
}
