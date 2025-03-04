import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'favorites_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of FavoritesLocalizations
/// returned by `FavoritesLocalizations.of(context)`.
///
/// Applications need to include `FavoritesLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/favorites_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FavoritesLocalizations.localizationsDelegates,
///   supportedLocales: FavoritesLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the FavoritesLocalizations.supportedLocales
/// property.
abstract class FavoritesLocalizations {
  FavoritesLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FavoritesLocalizations? of(BuildContext context) {
    return Localizations.of<FavoritesLocalizations>(context, FavoritesLocalizations);
  }

  static const LocalizationsDelegate<FavoritesLocalizations> delegate = _FavoritesLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('es')
  ];

  /// No description provided for @no_favorites_title.
  ///
  /// In es, this message translates to:
  /// **'Ohhh no!!'**
  String get no_favorites_title;

  /// No description provided for @no_favorites_subtitle.
  ///
  /// In es, this message translates to:
  /// **'No tienes películas favoritas'**
  String get no_favorites_subtitle;

  /// No description provided for @start_searching_lable.
  ///
  /// In es, this message translates to:
  /// **'Empieza a buscar'**
  String get start_searching_lable;

  /// No description provided for @upcoming_subtitle.
  ///
  /// In es, this message translates to:
  /// **'En este mes'**
  String get upcoming_subtitle;
}

class _FavoritesLocalizationsDelegate extends LocalizationsDelegate<FavoritesLocalizations> {
  const _FavoritesLocalizationsDelegate();

  @override
  Future<FavoritesLocalizations> load(Locale locale) {
    return SynchronousFuture<FavoritesLocalizations>(lookupFavoritesLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['es'].contains(locale.languageCode);

  @override
  bool shouldReload(_FavoritesLocalizationsDelegate old) => false;
}

FavoritesLocalizations lookupFavoritesLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'es': return FavoritesLocalizationsEs();
  }

  throw FlutterError(
    'FavoritesLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
