import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_tts/flutter_tts_web.dart';

enum TtsState { playing, stopped, paused, continued }

class TtsPlayer {
  final FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;
  double volume = 0.9;
  double pitch = 1.0;
  double rate = 0.5;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;
  get state => ttsState.toString();

  TtsPlayer() : flutterTts = FlutterTts();

  initTts() {
    // _getLanguages();

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        _getEngines();
      }
    }

    flutterTts.setStartHandler(() {
      print("Playing");
      ttsState = TtsState.playing;
    });

    flutterTts.setCompletionHandler(() {
      print("Stopped");
      ttsState = TtsState.stopped;
    });

    // flutterTts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
    //   var _currentWord = word;
    //   print("ProgressHandler - currentWord = $word");
    // });

    flutterTts.setCancelHandler(() {
      print("Cancel");
      ttsState = TtsState.stopped;
    });

    if (kIsWeb || Platform.isIOS) {
      flutterTts.setPauseHandler(() {
        print("Paused");
        ttsState = TtsState.paused;
      });

      flutterTts.setContinueHandler(() {
        print("Continued");
        ttsState = TtsState.continued;
      });
    }

    flutterTts.setErrorHandler((msg) {
      print("error: $msg");
      ttsState = TtsState.stopped;
    });

    flutterTts.setSpeechRate(0.5);
    flutterTts.setVolume(1.0);
  }

// Future _getLanguages() async {
//   languages = await flutterTts.getLanguages;
//   if (languages != null) setState(() => languages);
// }

  Future _getEngines() async {
    var engines = await flutterTts.getEngines;
    if (engines != null) {
      for (dynamic engine in engines) {
        print(engine);
      }
    }
  }

  Future speak({@required text}) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (text != null) {
      if (text.isNotEmpty) {
        await flutterTts.awaitSpeakCompletion(true);
        await flutterTts.speak(text);
      }
    }
  }

  Future stop() async {
    var result = await flutterTts.stop();
    if (result == 1) ttsState = TtsState.stopped;
  }

  Future pause() async {
    var result = await flutterTts.pause();
    if (result == 1) ttsState = TtsState.paused;
  }
}
