import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'person.model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveExampleUi extends StatefulWidget {
  @override
  _HiveExampleUiState createState() => _HiveExampleUiState();
}

class _HiveExampleUiState extends State<HiveExampleUi> {
  Box _personBox;
  //bool _isHiveInitialised = false;

  @override
  void initState() {
    super.initState();
    _openBox();

    if (!Hive.isAdapterRegistered(1))
      Hive.registerAdapter<PersonModel>(PersonModelAdapter());

    // if (_personBox == null)
    //   {
    //     print('favorites_page/initState - _personBox == null');
    //   } else {
    //   print('favorites_page/initState - _personBox.isOpen = ${_personBox.isOpen}');
    // }
  }

  Future _openBox() async {
    // var dir =  await getApplicationDocumentsDirectory();
    // Hive.init(dir.path);
    Box _box = await Hive.openBox('p');
    setState(() {
       _personBox = _box;
    });
    //await Future<void>.delayed(const Duration(milliseconds: 1000));
    if (_personBox == null)
    {
      print('favorites_page/_openBox - _personBox == null');
    } else {
      print('favorites_page/_openBox - _personBox.isOpen = ${_personBox.isOpen}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hive example"),
      ),
      body: Column(
        children: <Widget>[
          Wrap(
            children: <Widget>[
              FlatButton(
                child: Text("Add item "),
                onPressed: () {
                  PersonModel personModel = PersonModel(
                      Random().nextInt(100),
                      ""
                      "Vivek",
                      DateTime.now());
                  _personBox.add(personModel);
                },
              ),
              FlatButton(
                child: Text("Delete item "),
                onPressed: () {
                  int lastIndex = _personBox.toMap().length - 1;
                  if (lastIndex >= 0) _personBox.deleteAt(lastIndex);
                },
              ),
              FlatButton(
                child: Text("Update item "),
                onPressed: () {
                  int lastIndex = _personBox.toMap().length - 1;
                  if (lastIndex < 0) return;

                  PersonModel personModel =
                      _personBox.values.toList()[lastIndex];
                  personModel.birthDate = DateTime.now();
                  _personBox.putAt(lastIndex, personModel);
                },
              ),
            ],
          ),
          Text("Data in database"),
          _personBox == null
              ? Text("Box is not initialized")
              : Expanded(
                  child: ValueListenableBuilder(
                    valueListenable: _personBox.listenable(),
                    //box: _personBox,
                    builder: (context, box, widget) {
                      Map<dynamic, dynamic> raw = box.toMap();
                      List list = raw.values.toList();

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          PersonModel personModel = list[index];
                          return ListTile(
                            title: Text(personModel.name),
                            leading: Text(personModel.id.toString()),
                            subtitle: Text(
                                personModel.birthDate.toLocal().toString()),
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
