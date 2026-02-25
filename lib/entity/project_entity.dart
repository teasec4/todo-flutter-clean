class Project {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;

  Project({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
  });

  Project copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
  }) {
    return Project(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
