
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

/// A cache access provider class for shared preferences using Hive library
class HiveHandler extends CacheProvider {
  Box _box;

  @override
  Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (!kIsWeb) {
      Directory defaultDirectory = await getApplicationDocumentsDirectory();
      Hive.init(defaultDirectory.path);
    }
    _box = await Hive.openBox('app_preferences');
  }

  get keys => getKeys();

  @override
  bool getBool(String key) {
    return _box.get(key);
  }

  @override
  double getDouble(String key) {
    return _box.get(key);
  }

  @override
  int getInt(String key) {
    return _box.get(key);
  }

  @override
  String getString(String key) {
    return _box.get(key);
  }

  @override
  Future<void> setBool(String key, bool value) {
    return _box.put(key, value);
  }

  @override
  Future<void> setDouble(String key, double value) {
    return _box.put(key, value);
  }

  @override
  Future<void> setInt(String key, int value) {
    return _box.put(key, value);
  }

  @override
  Future<void> setString(String key, String value) {
    return _box.put(key, value);
  }

  @override
  Future<void> setObject<T>(String key, T value) {
    return _box.put(key, value);
  }

  @override
  bool containsKey(String key) {
    return _box.containsKey(key);
  }

  @override
  Set<E> getKeys<E>() {
    return _box.keys.cast<E>().toSet();
  }

  @override
  Future<void> remove(String key) async {
    if (containsKey(key)) {
      await _box.delete(key);
    }
  }

  @override
  Future<void> removeAll() async {
    final keys = getKeys();
    await _box.deleteAll(keys);
  }

  @override
  T getValue<T>(String key, T defaultValue) {
    var value = _box.get(key);
    if (value is T) {
      return value;
    }
    return defaultValue;
  }
}
