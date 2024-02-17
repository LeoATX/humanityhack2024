import 'dart:io';
import 'package:path/path.dart' show dirname;
import 'package:hive/hive.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import './database/event.dart';
import './routes.dart';

void main(List<String> args) async {
  // start HiveDB
  // \C:\\Users\\cyber\\OneDrive\\Documents\\GitHub\\humanityhack2024\\dart_shelf\\bin\\database
  Hive.init(
      '${Uri.file(dirname(Platform.script.toFilePath())).toFilePath()}/hive');
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
