import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:songwriting01/models/sentence.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:path_provider/path_provider.dart';

// enum ListAction {view, delete, update}

class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  Box _sentenceBox;
  //bool _isHiveInitialised = false;

  List<bool> _myListAction = [true, false, false];

  // bool get viewMode => _myListAction[0];
  // bool get updateMode => _myListAction[1];
  // bool get deleteMode => _myListAction[2];
  // int _selectedFavoriteIndex;

  @override
  void initState() {
    super.initState();
    if (!Hive.isAdapterRegistered(0))
      Hive.registerAdapter<Sentence>(SentenceAdapter());
    _openBox();
  }

  Future _openBox() async {
    Box _box = await Hive.openBox('p2');
    setState(() {
      _sentenceBox = _box;
    });
    //_sentenceBox.deleteFromDisk();
    //await Future<void>.delayed(const Duration(milliseconds: 1000));
    if (_sentenceBox == null) {
      print('favorites_page/_openBox - _personBox == null');
    } else {
      print(
          'favorites_page/_openBox - _personBox.isOpen = ${_sentenceBox.isOpen}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Sentences"),
      ),
      body: Column(
        children: <Widget>[
          Wrap(
            children: <Widget>[
              // ToggleButtons(
              //   children: <Widget>[
              //     Icon(Icons.remove_red_eye_outlined),
              //     Icon(Icons.brush),
              //     Icon(Icons.delete_sharp),
              //   ],
              //   isSelected: _myListAction,
              //   onPressed: (int index) {
              //     setState(() {
              //       for (int indexBtn = 0;
              //           indexBtn < _myListAction.length;
              //           indexBtn++) {
              //         if (indexBtn == index) {
              //           _myListAction[indexBtn] = true;
              //         } else {
              //           _myListAction[indexBtn] = false;
              //         }
              //       }
              //       if (deleteMode) {
              //         _sentenceBox.deleteAt(_selectedFavoriteIndex);
              //       } else if (updateMode) {
              //       } else if (viewMode) {}
              //       _selectedFavoriteIndex = null;
              //       //_myListAction[index] = !_myListAction[index];
              //     });
              //   },
              // ),
              // FlatButton(
              //   child: Text("Delete item "),
              //   onPressed: () {
              //     //_myListAction != ListAction.delete ? _myListAction = ListAction.delete
              //     int lastIndex = _sentenceBox.toMap().length - 1;
              //     if (lastIndex >= 0) _sentenceBox.deleteAt(lastIndex);
              //   },
              // ),
              // FlatButton(
              //   child: Text("Update item "),
              //   onPressed: () {
              //     int lastIndex = _sentenceBox.toMap().length - 1;
              //     if (lastIndex < 0) return;
              //
              //     Sentence sentence = _sentenceBox.values.toList()[lastIndex];
              //     sentence.stars = 1;
              //     _sentenceBox.putAt(lastIndex, sentence);
              //   },
              // ),
            ],
          ),
          // Text("Data in database"),
          _sentenceBox == null
              ? Text("Box is not initialized")
              : Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _sentenceBox.listenable(),
                    //box: _personBox,
                    builder: (context, box, widget) {
                      Map<dynamic, dynamic> raw = box.toMap();
                      List list = raw.values.toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          Sentence sentence = list[index];
                          print('favorites_page/ListView.builder - sentence.stars = ${sentence.stars ?? 0}');
                          return ListTile(
                            // selected: _selectedFavoriteIndex == null
                            //     ? false
                            //     : _selectedFavoriteIndex == index,

                            // onTap: (viewMode) ? () {
                            // } : (){
                            //   if (updateMode) {
                            //     print(index);
                            //
                            //   } else if (deleteMode) {
                            //
                            //     //_sentenceBox.deleteAt(index);
                            //     //print(index);
                            //   }
                            // },
                            //     (){
                            //   print('favorites_page/ListTile - index = $index');
                            // },
                            leading: RatingBar(
                              initialRating: sentence.stars?.toDouble() ?? 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              itemCount: 4,
                              itemSize: 20,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 2.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                sentence.stars = rating.toInt();
                                  _sentenceBox.putAt(index, sentence);
                                // print(rating);
                              },
                            ),
                            title:
                                // GestureDetector(
                                //       onTap: () {
                                //         setState(() {
                                //           _selectedFavoriteIndex == index
                                //               ? _selectedFavoriteIndex = null
                                //               : _selectedFavoriteIndex = index;
                                //         });
                                //       },
                                //       child:
                                Text(sentence.sentence),
                            // ),
                            //subtitle: Text(index.toString()),
                            // subtitle: Text(
                            //     sentence.comment()),
                            trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  _sentenceBox.deleteAt(index);
                                }),
                          );
                        },
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
