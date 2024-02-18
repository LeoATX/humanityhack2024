import 'package:hive/hive.dart';
part 'event.g.dart';

@HiveType(typeId: 1)
class Event extends HiveObject {
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
        'startTime': startTime.millisecondsSinceEpoch,
        'endTime': endTime.millisecondsSinceEpoch,
        'url': url
      };

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      name: json['name'],
      organization: json['organization'],
      description: json['description'],
      startTime:
          DateTime.fromMillisecondsSinceEpoch(int.parse(json['startTime'])),
      endTime: DateTime.fromMillisecondsSinceEpoch(int.parse(json['endTime'])),
      url: json['url'],
    );
  }
}
