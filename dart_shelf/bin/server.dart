import 'dart:io';
import 'package:hive/hive.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:hive/hive.dart';
import './database/database_manager.dart';
import './database/event.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf/shelf.dart';
import 'database/event.dart';
import 'routes.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler)
  ..get('/getEvents', _getEventsHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Future<Response> _dataHandler(Request request) async {
  List<Event> events = await DB.instance.getAllEvents();

  return Response.ok('${events.length}\n');
}

Future<Response> _getEventsHandler(Request request) async {
  List<Event> events = await DB.instance.getAllEvents();

  return Response.ok('${events.length}\n');
}

void main(List<String> args) async {
  // start HiveDB
  Hive.init('/hive');
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
