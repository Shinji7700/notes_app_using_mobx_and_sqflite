const String sqlTableName = 'notes';

class SqlTableFields {
  static final List<String> values = [
    /// Add all fields
    id, title, description, createdAt
  ];
  static const String id = "_id";
  static const String title = "title";
  static const String description = "description";
  static const String createdAt = "createdAt";
}

class NotesModel {
  NotesModel({
    this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });
  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;

  Map<String, Object?> toJson() => {
        SqlTableFields.id: id,
        SqlTableFields.title: title,
        SqlTableFields.description: description,
        SqlTableFields.createdAt: createdAt.toIso8601String(),
      };

  static NotesModel fromJson(Map<String, Object?> json) => NotesModel(
      id: json[SqlTableFields.id] as int?,
      title: json[SqlTableFields.title] as String,
      description: json[SqlTableFields.description] as String,
      createdAt: DateTime.parse(json[SqlTableFields.createdAt] as String));

  NotesModel copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
  }) {
    return NotesModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
