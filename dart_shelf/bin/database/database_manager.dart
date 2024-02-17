import 'package:hive/hive.dart';
import './event.dart';

class DB {
  static final DB instance = DB._init();
  static Box? _box;

  DB._init();

  Future<Box> get box async {
    if (_box != null) return _box!;

    _box = await Hive.openBox('config');
    return _box!;
  }

  Future<List<Event>> getAllDailyTracks() async {
    return (await box).values.cast<Event>().toList();
  }
}
