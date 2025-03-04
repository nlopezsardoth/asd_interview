// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'movies_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class MoviesLocalizationsEs extends MoviesLocalizations {
  MoviesLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get search_movies_label => 'Buscar películas';

  @override
  String get loading_movies_error => 'Error loading movies';

  @override
  String get now_playing_title => 'En cines';

  @override
  String get now_playing_subtitle => 'Lunes 20';

  @override
  String get upcoming_title => 'Próximamente';

  @override
  String get upcoming_subtitle => 'En este mes';

  @override
  String get top_rated_title => 'Mejor calificadas';

  @override
  String get top_rated_subtitle => 'Mejor calificadas';
}
