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

  Future addEvent(Event event) async {
    (await box).add(event);
  }

  Future<List<Event>> getEvents(
      {required DateTime startTime, required DateTime endTime}) async {
    List<Event> allEvents = await getAllEvents();
    return allEvents
        .where((event) => (event.startTime.compareTo(startTime) < 0 &&
            event.endTime.compareTo(endTime) > 0))
        .toList();
  }

  Future<List<Event>> getAllEvents() async {
    return (await box).values.cast<Event>().toList();
  }
}
