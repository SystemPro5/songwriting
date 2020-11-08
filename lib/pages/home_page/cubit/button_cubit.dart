import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'button_state.dart';

class SentencesCubit extends Cubit<SentencesState> {
  bool isPaused = true;
  SentencesCubit() : super(Paused());

  void pauseSentenceGenerator() {
    isPaused = true;
    emit(Paused());
  }

  void resumeSentenceGenerator() {
    isPaused = false;
    emit(Playing());
  }

  void toggleSentencesGenerator() {
    if (isPaused) {resumeSentenceGenerator();}
    else {
      pauseSentenceGenerator();
    }
  }
}

