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

  return router;
}

// route handlers
Response _rootHandler(Request req) {
  return Response.badRequest(body: 'This is a root reqeust');
}

Future<Response> _addEvent(Request request) async {
  return Response.ok('Tested\n');
}

Future<Response> _getEvents(Request request) async {

  Map<String, dynamic> requestParameters = request.requestedUri.queryParameters;

  // get events from Andrew's db
  List<Event> events = await DB.instance.getEvents(
      startTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(requestParameters['startTime'])),
      endTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(requestParameters['endTime'])));
  // TODO

  // get the response ready
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

  return Response.ok(jsonEncode(response));
}

// Future<Response> _getAllEventsHandler(Request request) async {
  // List<Event> events = await DB.instance.getAllEvents();

  // Map<String, dynamic> response = {
  //   'eventCount': 0,
  //   'lat': 37.349167,
  //   'lng': -121.938056
  // };

  // List<dynamic> eventsJson = [];
  // for (var event in events) {
  //   eventsJson.add(event.toJson());
  // }

  // response['events'] = eventsJson;

  // return Response.ok('${jsonEncode(response)}\n');
// }
