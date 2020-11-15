import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter/cupertino.dart';

class AppSettingsPage extends StatefulWidget {
  @override
  _AppSettingsPageState createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SettingsScreen(
        title: "Application Settings",
        children: [
          SettingsGroup(
            title: 'USER INTERFACE',
            children: <Widget>[
              SwitchSettingsTile(
                settingKey: 'key-dark-mode',
                title: 'Dark mode',
                enabledLabel: 'Enabled',
                disabledLabel: 'Disabled',
                leading: Icon(CupertinoIcons.moon_fill),
                onChange: (value) {
                  debugPrint('key-dark-mode: $value');
                },
              ),
            ],
          ),
          SettingsGroup(
            title: 'Text to speech',
            children: <Widget>[
              SliderSettingsTile(
                title: 'Volume',
                settingKey: 'key-slider-volume',
                defaultValue: 0.5,
                min: 0.0,
                max: 1.0,
                step: 0.1,
                // leading: Icon(Icons.volume_up),
                onChangeEnd: (value) {
                  debugPrint('\n===== on change end =====\n'
                      'key-slider-volume: $value'
                      '\n==========\n');
                },
              ),
              SliderSettingsTile(
                title: 'Rate',
                settingKey: 'key-slider-rate',
                defaultValue: 0.9,
                min: 0.5,
                max: 1.0,
                step: 0.05,
                // leading: Icon(Icons.volume_up),
                onChangeEnd: (value) {
                  debugPrint('\n===== on change end =====\n'
                      'key-slider-rate: $value'
                      '\n==========\n');
                },
              ),
              SliderSettingsTile(
                title: 'Pause after sentence (sec)',
                settingKey: 'key-slider-sentence-seperation-time',
                defaultValue: 2.0,
                min: 0.0,
                max: 5.0,
                step: 1.0,
                // leading: Icon(Icons.volume_up),
                onChangeEnd: (value) {
                  debugPrint('\n===== on change end =====\n'
                      'key-slider-sentence-seperation-time: $value'
                      '\n==========\n');
                },
              ),
              SliderSettingsTile(
                title: 'Pitch',
                settingKey: 'key-slider-pitch',
                defaultValue: 1.0,
                min: 0.0,
                max: 2.0,
                step: 0.1,
                // leading: Icon(Icons.volume_up),
                onChangeEnd: (value) {
                  debugPrint('\n===== on change end =====\n'
                      'key-slider-pitch: $value'
                      '\n==========\n');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
