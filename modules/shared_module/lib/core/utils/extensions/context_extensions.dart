import 'package:favorites_module/core/l10n/favorites_localizations.dart';
import 'package:flutter/material.dart';
import 'package:movies_module/core/l10n/movies_localizations.dart';
import 'package:shared_module/core/l10n/shared_localizations.dart';

extension BuildContextExt on BuildContext {

  ThemeData get theme => Theme.of(this);


  SharedLocalizations get l10nShared => SharedLocalizations.of(this)!;

  MoviesLocalizations get l10nMovies => MoviesLocalizations.of(this)!;

  FavoritesLocalizations get l10nFavorites => FavoritesLocalizations.of(this)!;

}
