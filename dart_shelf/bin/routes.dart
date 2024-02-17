import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import './database/database_manager.dart';
import './database/event.dart';

Router get router {
  final router = Router();
  router.get('/', _rootHandler);
  router.get('/echo/<message>', _echoHandler);
  router.get('/data', _dataHandler);

  return router;
}

// route handlers
Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

Future<Response> _dataHandler(Request request) async {
  List<Event> events = await DB.instance.getAllDailyTracks();

  return Response.ok('${events.length}\n');
}