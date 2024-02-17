import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import './database/database_manager.dart';
import './database/event.dart';
import 'dart:convert';

Router get router {
  final router = Router();
  router.get('/', _rootHandler);
  router.get('/addEvent', _addEvent);
  router.get('/getEvents', _getEventsHandler);
  router.get('/getAllEvents', _getAllEventsHandler);

  return router;
}

// route handlers
Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Future<Response> _addEvent(Request request) async {
  return Response.ok('Tested\n');
}

Future<Response> _getEventsHandler(Request request) async {
  return Response.ok('Tested\n');
}

Future<Response> _getAllEventsHandler(Request request) async {
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
