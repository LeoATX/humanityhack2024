import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import './database/database_manager.dart';
import './database/event.dart';
import 'dart:convert';

Router get router {
  final router = Router();
  router.get('/', _rootHandler);
  router.get('/addEvent', _addEventHandler);
  router.get('/getEvents', _getEventsHandler);
  router.get('/getAllEvents', _getAllEventsHandler);

  return router;
}

// route handlers
Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Future<Response> _addEventHandler(Request request) async {
  List<Event> events = await DB.instance.getAllEvents();

  return Response.ok('${events.length}\n');
}

Future<Response> _getEventsHandler(Request request) async {
  List<Event> events = await DB.instance.getAllEvents();

  return Response.ok('${events.length}\n');
}

Future<Response> _getEventsHandler(Request request) async {
  List<Event> events = await DB.instance.getAllEvents();

  Map<String, dynamic> response = {
    'eventCount': 0,
    'lat': 37.349167,
    'lng': -121.938056
  };

  List<dynamic> eventsJson = [];
  for (var event in events) {
    eventsJson.add(event.toJson());
  }

  response['events'] = eventsJson;

  return Response.ok('${jsonEncode(response)}\n');
}
