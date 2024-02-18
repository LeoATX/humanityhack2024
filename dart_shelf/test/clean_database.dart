import 'dart:io';
import 'package:path/path.dart' show dirname;
import 'package:hive/hive.dart';
import '../bin/database/database_manager.dart';
import '../bin/database/event.dart';

void main() async {
  String rootPath =
      Uri.file(dirname(dirname(Platform.script.toFilePath()))).toFilePath();
  Hive.init('$rootPath/bin/hive');
  Hive.registerAdapter(EventAdapter());

  List<Event> allEvents = await DB.instance.getAllEvents();

  List<int> eventsToDelete = [];

  for (Event event in allEvents) {
    int key = event.key;

    if (key > 9) {
      eventsToDelete.add(key);
    }
  }

  await DB.instance.removeAllEvents(eventsToDelete);

  print('Successfully deleted ${eventsToDelete.length} events :)');
}
