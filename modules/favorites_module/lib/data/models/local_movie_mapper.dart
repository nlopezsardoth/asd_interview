import 'package:movies_module/domain/entities/movie.dart';

class LocalMovieMapper {
    static Map<String, dynamic> entityToMap(Movie movie) {
    return {
      'id': movie.id,
      'title': movie.title,
      'posterPath': movie.posterPath,
      'overview': movie.overview,
      'releaseDate': movie.releaseDate.toIso8601String(),
      'voteAverage': movie.voteAverage,
      'genreIds': movie.genreIds,
      'backdropPath': movie.backdropPath,
      'adult': movie.adult,
      'originalLanguage': movie.originalLanguage,
      'originalTitle': movie.originalTitle,
      'popularity': movie.popularity,
      'video': movie.video,
      'voteCount': movie.voteCount,
    };
  }

  static Movie mapToEntity(Map<dynamic, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] as String,
      posterPath: map['posterPath'] as String,
      overview: map['overview'] as String,
      releaseDate: DateTime.parse(map['releaseDate'] as String),
      voteAverage: (map['voteAverage'] as num).toDouble(),
      genreIds: List<String>.from(map['genreIds'] as List),
      backdropPath: map['backdropPath'] as String,
      adult: map['adult'] as bool,
      originalLanguage: map['originalLanguage'] as String,
      originalTitle: map['originalTitle'] as String,
      popularity: (map['popularity'] as num).toDouble(),
      video: map['video'] as bool,
      voteCount: map['voteCount'] as int,
    );
  }
}