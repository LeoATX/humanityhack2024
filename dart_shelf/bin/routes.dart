import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import './database/database_manager.dart';
import './database/event.dart';

Router get router {
  final router = Router();
  router.get('/', _rootHandler);
  router.get('/addEvent', _addEvent);
  router.get('/getEvents', _getEvents);
  // router.get('/getAllEvents', _getAllEventsHandler);
  router.get('/nuke', _nuke);

  return router;
}

// helper functions
/// Returns a parameter that is missing or null if nothing is missing
String? checkParameters(
    List<String> requiredParameters, Map<String, String> queryParameters) {
  for (String param in requiredParameters) {
    if (!queryParameters.keys.contains(param)) {
      return param;
    }
  }

  return null;
}

const Map<String, Object> corsHeaders = {'Access-Control-Allow-Origin': '*'};

Response corsWrapperOk(Object body) {
  return Response.ok(body, headers: corsHeaders);
}

Response corsWrapperBad(Object body) {
  return Response.badRequest(body: body, headers: corsHeaders);
}

// route handlers
Response _rootHandler(Request req) {
  return corsWrapperBad('This is a root request');
}

Future<Response> _addEvent(Request request) async {
  Map<String, String> queryParameters = request.requestedUri.queryParameters;

  List<String> requiredParameters = ['name', 'startTime', 'endTime'];
  String? missingParameter =
      checkParameters(requiredParameters, queryParameters);
  if (missingParameter != null) {
    return corsWrapperBad(
        jsonEncode({'error': 'Missing parameter $missingParameter'}));
  }

  Event eventToAdd = Event.fromJson(queryParameters);
  await DB.instance.addEvent(eventToAdd);

  return corsWrapperOk(jsonEncode({'message': 'Success'}));
}

Future<Response> _getEvents(Request request) async {
  Map<String, String> requestParameters = request.requestedUri.queryParameters;

  List<String> requiredParameters = ['startTime', 'endTime'];
  String? missingParameter =
      checkParameters(requiredParameters, requestParameters);
  if (missingParameter != null) {
    return corsWrapperBad(
        jsonEncode({'error': 'Missing parameter $missingParameter'}));
  }

  // get events from Andrew's db
  List<Event> events = await DB.instance.getEvents(
      startTime: DateTime.fromMillisecondsSinceEpoch(
          int.parse(requestParameters['startTime']!)),
      endTime: DateTime.fromMillisecondsSinceEpoch(
          int.parse(requestParameters['endTime']!)));

  // get the response ready
  Map<String, dynamic> response = {
    'eventCount': events.length,
  };

  response['events'] = events.map((e) => e.toJson()).toList();

  return corsWrapperOk(jsonEncode(response));
}

Response _nuke(Request request) {
  DB.instance.nuke();
  return corsWrapperOk('Success');
}
