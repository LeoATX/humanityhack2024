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

  for (Event event in allEvents) {
    print('name: ${event.name}');
    print('organization: ${event.organization}');
    print('description: ${event.description}');
    print('url: ${event.url}');
    print('start time: ${event.startTime}');
    print('end time: ${event.endTime}');
    print('\n');
  }

  print('There are ${allEvents.length} events');
}
