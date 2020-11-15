// import 'dart:async';
// import 'dart:io';
// import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:songwriting01/pages/favorites_page/favorites_page.dart';
import 'package:songwriting01/pages/home_page/cubit/sentences_cubit.dart';
import 'package:songwriting01/models/sentence.dart';
import 'package:songwriting01/pages/settings_page/app_settings_page.dart';
//import 'package:flutter_tts/flutter_tts_web.dart';

import '../../data/sentence_vocabulary.dart';

// enum TtsState { playing, stopped, paused, continued }

class HomePage extends StatefulWidget {
  HomePage({String title});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSentenceGeneratorOn = false;

  List<Sentence> sentences;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Songwriting inspiration tool'),
      ),
      body: BlocBuilder<SentencesCubit, SentencesState>(
        builder: (context, state) {
          print('home_page/body state = $state');

          if (state is SentencesInitial) {
            isSentenceGeneratorOn = state.isSentenceGeneratorOn;
            sentences = state.sentences;
            print('home_page - state = SentencesInitial');
            print('home_page - isSentenceGeneratorOn = $isSentenceGeneratorOn');
            print('home_page - sentences = $sentences');
            context.bloc<SentencesCubit>().initialiseCubit();
            // return Container();
            // setState(() {

            // });

          } else if (state is SentencesLoading) {
            print('home_page - state = SentencesLoading');
            return buildLoading();
          } else if (state is SentencesLoaded) {
            print('home_page - state = SentencesLoaded');
            // setState(() {
            print('home_page - state = SentencesLoaded = $sentences');

            sentences = state.sentences;

            // });
            print('home_page - state = SentencesLoaded = $sentences');
            // switchSentenceGenerator(positionOn: !isSentenceGeneratorOn);
            // sentences = state.sentences;
            // return buildColumnWithData(sentences: state.sentences);
          } else {
            print('home_page - state = undefined');
            // return buildColumnWithData(
            //     sentences: (state as SentencesLoaded).sentences);
          }
          return buildColumnWithData(context: context, sentences: sentences);
        },
      ),

      floatingActionButton: BlocBuilder<SentencesCubit, SentencesState>(
        builder: (context, state) {
          if (state is SentencesLoaded) {
            isSentenceGeneratorOn = state.isSentenceGeneratorOn;
          }
          print('home_page/floatingactionbutton state = $state');
          print(
              'home_page/floatingactionbutton isSentenceGeneratorOn = $isSentenceGeneratorOn');
          //
          //   print(
          //       'home_page - state = SentencesLoaded (FloatingActionButton)');
          //   print(
          //       'home_page - state = isSentenceGeneratorOn = $isSentenceGeneratorOn');
          return FloatingActionButton(
            onPressed: () {
              isSentenceGeneratorOn = !isSentenceGeneratorOn;
              isSentenceGeneratorOn
                  ? context.bloc<SentencesCubit>().setSentenceGeneratorOn()
                  : context.bloc<SentencesCubit>().setSentenceGeneratorOff();
            },
            tooltip: 'Sentence Generator Switch',
            child: isSentenceGeneratorOn
                ? Icon(Icons.pause)
                : Icon(Icons.play_arrow),
          );

        },
      ),
      bottomNavigationBar: BlocBuilder<SentencesCubit, SentencesState>(
          builder: (context, state) {
        print('home_page/floatingactionbutton state = $state');
        //
        //   print(
        //       'home_page - state = SentencesLoaded (FloatingActionButton)');
        //   print(
        //       'home_page - state = isSentenceGeneratorOn = $isSentenceGeneratorOn');
        return BottomNavigationBar(
          onTap: _onTap,
          currentIndex: 0, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home), //Icon(Icons.star_border),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            )
          ],
        );
      }),

      //This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _onTap(int index) {
    switch (index) {
      case 0:
        {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              builder: (BuildContext context) => AppSettingsPage()));
        }
        break;
      case 1:
        {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              builder: (BuildContext context) => FavoritesPage()));
        }
        break;
      case 2:
        {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              builder: (BuildContext context) => AppSettingsPage()));
        }
        break;
    }
  }
}

Widget buildLoading() {
  print('home_page/buildLoading CircularProgressIndicator');
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildColumnWithData({BuildContext context, @required List<Sentence> sentences}) {
  if (sentences == null) {
    print('home_page/buildcolumnWithData - sentences == null');
  }
  print('home_page/sentences = $sentences');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 5),
      (sentences.isEmpty)
          ? Container()
          : Container(
        width: MediaQuery.of(context).copyWith().size.width,
  // constraints: BoxConstraints.expand(),
                padding: const EdgeInsets.all(20.0),
                color: Colors.blueGrey,
                child: Text(sentences.first.sentence,
                    textScaleFactor: 2.0, style: TextStyle(color: Colors.white)),
              ),

      Expanded(
        child: (sentences.length == 0)
            ? Center(child: const Text('No items'))
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.all(20.0),
                itemCount: sentences.length,
                itemBuilder: (BuildContext context, int index) {
                  // return Text(resultList[resultList.length - index - 1]);
                  return ListTile(
                      title: Text(sentences[index].sentence,
                          style: TextStyle(fontSize: 20)),
                      //isThreeLine: true,
                      // subtitle: Text('Secondary text\nTertiary text'),
                      // leading: Icon(Icons.label),
                      trailing: IconButton(
                        icon: (sentences[index].stars == null)
                            ? Icon(Icons.favorite_border)
                            : Icon(Icons.favorite),
                        onPressed: () {
                          context
                              .bloc<SentencesCubit>()
                              .setSentenceFavorite(index: index);
                        },
                      ));
                  // Center(child: Text(sentences[index].sentence,style: TextStyle(fontSize: 20)));
                  // return Center(child: Text(resultList.reversed.toList()[index]));
                },
              ),
      )
    ],
  );
}
