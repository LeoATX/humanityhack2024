import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import './database/database_manager.dart';
import './database/event.dart';
import 'dart:convert';

Router get router {
  final router = Router();
  router.get('/', _rootHandler);
  router.get('/addEvent', _addEvent);
  router.get('/getEvents', _getEvents);
  // router.get('/getAllEvents', _getAllEventsHandler);
  router.get('/nuke', _nuke);

  return router;
}

// route handlers
Response _rootHandler(Request req) {
  return Response.badRequest(body: 'This is a root reqeust');
}

Future<Response> _addEvent(Request request) async {
  Map<String, String> queryParameters = request.requestedUri.queryParameters;

  List<String> requiredParameters = ['name', 'startTime', 'endTime'];
  for (String param in requiredParameters) {
    if (!queryParameters.keys.contains(param)) {
      return Response.badRequest(
          body: jsonEncode({'error': 'Missing parameter $param'}));
    }
  }

  Event eventToAdd = Event.fromJson(queryParameters);
  await DB.instance.addEvent(eventToAdd);

  return Response.ok(jsonEncode({'message': 'Success'}));
}

Future<Response> _getEvents(Request request) async {
  Map<String, dynamic> requestParameters = request.requestedUri.queryParameters;

  List<String> requiredParameters = ['startTime', 'endTime'];
  for (String param in requiredParameters) {
    if (!requestParameters.keys.contains(param)) {
      return Response.badRequest(
          body: jsonEncode({'error': 'Missing parameter $param'}));
    }
  }

  // get events from Andrew's db
  List<Event> events = await DB.instance.getEvents(
      startTime: DateTime.fromMillisecondsSinceEpoch(
          int.parse(requestParameters['startTime'])),
      endTime: DateTime.fromMillisecondsSinceEpoch(
          int.parse(requestParameters['endTime'])));

  // all events for testing purposes
  // List<Event> allEvents = await DB.instance.getAllEvents();

  // get the response ready
  Map<String, dynamic> response = {
    'eventCount': events.length,
    'lat': 37.349167,
    'lng': -121.938056
  };

  List<dynamic> eventsJson = [];
  for (var event in events) {
    eventsJson.add(event.toJson());
  }

  response['events'] = eventsJson;

  print(events.toString());
  return Response.ok(jsonEncode(response));
}

Response _nuke(Request request) {
  DB.instance.nuke();
  return Response.ok('Success');
}
