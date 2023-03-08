final String tableRepos = 'repos';

class NoteFields {
  static final List<String> values = [id, name, description, time];

  static final String id = '_id';
  static final String name = 'name';
  static final String description = 'description';
  static final String time = 'time';
}

class Git {
  final int? id;
  final String name;
  final String description;
  final DateTime created_at;

  const Git({
    this.id,
    required this.name,
    required this.description,
    required this.created_at,
  });

  Git copy({
    int? id,
    String? name,
    String? description,
    DateTime? created_at,
  }) =>
      Git(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        created_at: created_at ?? this.created_at,
      );

  ///Sql
  static Git fromJson(Map<String, Object?> json) => Git(
    id: json[NoteFields.id] as int,
    name: json[NoteFields.name] as String,
    description: json[NoteFields.description] as String,
    created_at: DateTime.parse(json[NoteFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    NoteFields.id: id,
    NoteFields.name: name,
    NoteFields.description: description,
    NoteFields.time: created_at.toIso8601String(),
  };

  ///Api
  factory Git.fromJsonApi(Map<String, dynamic> json) {
    return Git(
        id: json['id'],
        name: json['name'].toString(),
        description: json['description'].toString(),
        created_at: DateTime.parse(json['created_at'])
    );
  }

  Map<String, dynamic> toJsonApi() => {
    'id': id,
    'name': name,
    'description': description,
    'created_at':created_at
  };
}
