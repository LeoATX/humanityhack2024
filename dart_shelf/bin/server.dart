import './database/event.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf/shelf.dart';
import 'routes.dart';

void main(List<String> args) async {
  // start HiveDB
  String pathHive = '${dirname(Platform.script.path)}/hive';
  Hive.init(pathHive);
  print(pathHive);
  Hive.registerAdapter(EventAdapter());

  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
