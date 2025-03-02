import 'package:movies_module/data/models/moviedb/movie_details.dart';
import 'package:movies_module/data/models/moviedb/movie_moviedb.dart';
import 'package:movies_module/domain/entities/movie.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath:
        (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://www.movienewz.com/img/films/poster-holder.jpg',
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath:
        (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'https://www.movienewz.com/img/films/poster-holder.jpg',
    releaseDate:
        moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(),
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
  );

  static Movie movieDetailsToEntity(MovieDetails moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath:
        (moviedb.backdropPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
            : 'https://www.movienewz.com/img/films/poster-holder.jpg',
    genreIds: moviedb.genres.map((e) => e.name).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath:
        (moviedb.posterPath != '')
            ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
            : 'https://www.movienewz.com/img/films/poster-holder.jpg',
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount,
  );

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
