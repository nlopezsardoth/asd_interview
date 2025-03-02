class Actor {
  final int id;
  final String name;
  final String profilePath;
  final String? character;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.character,
  });

  Actor copyWith({
    int? id,
    String? name,
    String? profilePath,
    String? character,
  }) {
    return Actor(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePath: profilePath ?? this.profilePath,
      character: character ?? this.character,
    );
  }
}
