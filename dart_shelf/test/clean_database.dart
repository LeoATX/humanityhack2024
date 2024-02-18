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

  List<int> eventsToDelete = [
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25
  ];

  await DB.instance.removeAllEvents(eventsToDelete);

  print('Successfully deleted :)');
}
