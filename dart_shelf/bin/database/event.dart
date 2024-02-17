import 'package:hive/hive.dart';
part 'event.g.dart';

@HiveType(typeId: 1)
class Event {
  @HiveField(0)
  String name;
  @HiveField(1)
  String? organization;
  @HiveField(2)
  String? description;
  @HiveField(3)
  DateTime startTime;
  @HiveField(4)
  DateTime endTime;
  @HiveField(5)
  String? url;

  Event(
      {required this.name,
      this.organization,
      this.description,
      required this.startTime,
      required this.endTime,
      this.url});

  Map<String, dynamic> toJson() => {
        'name': name,
        'organization': organization,
        'description': description,
        'startTime': startTime,
        'endTime': endTime,
        'url': url
      };

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      organization: json['organization'],
      description: json['description'],
      startTime: json['startTime'], // TODO: fix startTime and endTime input
      endTime: json['endTime'],
      url: json['url'],
    );
  }
}
