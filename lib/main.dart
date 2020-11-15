import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hive/hive.dart';
import 'package:songwriting01/models/sentence.dart';
import 'package:songwriting01/pages/home_page/cubit/sentences_cubit.dart';
import 'package:songwriting01/data_handler/app_settings_handler.dart';
import 'package:songwriting01/pages/home_page/home_page.dart';
import 'file:///C:/Users/Mike/AndroidStudioProjects/songwriting01/lib/tools/sentence_generator.dart';

bool _isDarkTheme = true;
// bool _isUsingHive = true;

void main() async {
  await initAppSettings();
  runApp(MyApp());
}

//initSettings for the flutter_settings_screen package
Future<void> initAppSettings() async {
  await Settings.init(cacheProvider: HiveHandler()
      //cacheProvider: _isUsingHive ? HiveHandler(boxName: 'app_preferences') : SharePreferenceCache(),
      );
  // await Settings.init(cacheProvider: HiveHandler(boxName: 'favorite_sentences'));
  Hive.registerAdapter(SentenceAdapter());
  await Hive.openBox('p2');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //home: HomePage(title: 'Inspiration For Songwriting'),
        home: MultiBlocProvider(
          providers: [
            BlocProvider<SentencesCubit>(
              create: (context) =>
                  SentencesCubit(),
            ),
            // BlocProvider<SentencesCubit>(
            //   create: (BuildContext context) => SentencesCubit(),
            // ),
          ],
          child: HomePage(title: 'Inspiration For Songwriting'),
        )

        // BlocProvider(
        //   create: (context) => SentencesCubit(sentenceHandler: SentenceHandler()),
        //   child:  HomePage2(title: 'Inspiration For Songwriting'),
        // ),
        );
  }
}
