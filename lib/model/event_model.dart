const String tableEvents = 'events';

class EventFields {
  static final List<String> values = [id, title, description, from, to, time];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String from = 'from';
  static const String to = 'to';
  static const String time = 'time';
}

class Event {
  final int? id;
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final DateTime createdTime;

  const Event({
    this.id,
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    required this.createdTime,
  });

  Event copy({
    int? id,
    String? title,
    String? description,
    DateTime? from,
    DateTime? to,
    DateTime? createdTime,
  }) =>
      Event(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        from: from ?? this.from,
        to: to ?? this.to,
        createdTime: createdTime ?? this.createdTime,
      );

  static Event fromJson(Map<String, Object?> json) => Event(
      id: json[EventFields.id] as int?,
      title: json[EventFields.title] as String,
      description: json[EventFields.description] as String,
      from: DateTime.parse(json[EventFields.from] as String),
      to: DateTime.parse(json[EventFields.to] as String),
      createdTime: DateTime.parse(json[EventFields.time] as String));

  Map<String, Object?> toJson() => {
        EventFields.id: id,
        EventFields.title: title,
        EventFields.description: description,
        EventFields.from: from.toIso8601String(),
        EventFields.to: to.toIso8601String(),
        EventFields.time: createdTime.toIso8601String(),
      };
}
