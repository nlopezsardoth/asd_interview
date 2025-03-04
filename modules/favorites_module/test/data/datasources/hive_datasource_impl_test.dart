import 'package:favorites_module/data/datasources/hive_datasource_impl.dart';
import 'package:favorites_module/data/models/local_movie_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:shared_module/data/errors/exceptions.dart';

import '../mocks/hive_mock_helper.mocks.dart';


void main() {
  late HiveDatasourceImpl datasource;
  late MockBox<Map> mockBox;


  setUp(() {
    mockBox = MockBox<Map>();
    datasource = HiveDatasourceImpl(box: mockBox);

  });

  tearDown(() async {
    reset(mockBox);
  });

  final testMovie = Movie(
      adult: false,
      backdropPath: '/test.jpg',
      genreIds: ['Action', 'Adventure'],
      id: 123,
      originalLanguage: 'en',
      originalTitle: 'Test Movie',
      overview: 'A test movie overview.',
      popularity: 8.5,
      posterPath: '/test_poster.jpg',
      releaseDate: DateTime(2023, 12, 31),
      title: 'Test Movie',
      video: false,
      voteAverage: 7.5,
      voteCount: 1000,
    );

  group('isMovieFavorite', () {
    test(
      'GIVEN a stored movie WHEN checking if favorite THEN should return true',
      () async {
        when(mockBox.containsKey(any)).thenReturn(true);

        final result = await datasource.isMovieFavorite(testMovie.id);

        expect(result, isTrue);
        verify(mockBox.containsKey(testMovie.id)).called(1);
      },
    );

    test(
      'GIVEN no stored movie WHEN checking if favorite THEN should return false',
      () async {
        when(mockBox.containsKey(any)).thenReturn(false);

        final result = await datasource.isMovieFavorite(testMovie.id);

        expect(result, isFalse);
        verify(mockBox.containsKey(testMovie.id)).called(1);
      },
    );

    test(
      'GIVEN a Hive exception WHEN checking if favorite THEN should throw LocalDatabaseException',
      () async {
        when(mockBox.containsKey(any)).thenThrow(Exception('Hive error'));

        expect(
          () async => await datasource.isMovieFavorite(testMovie.id),
          throwsA(isA<LocalDatabaseException>()),
        );
      },
    );
  });

  group('toggleFavorite', () {

    test(
      'GIVEN a non-favorite movie WHEN toggling favorite THEN should store it',
      () async {
        when(mockBox.containsKey(any)).thenReturn(false);
        when(mockBox.put(any, any)).thenAnswer((_) async {});

        await datasource.toggleFavorite(testMovie);

        verify(mockBox.put(testMovie.id, LocalMovieMapper.entityToMap(testMovie))).called(1);
      },
    );

    test(
      'GIVEN a favorite movie WHEN toggling favorite THEN should remove it',
      () async {
        when(mockBox.containsKey(any)).thenReturn(true);
        when(mockBox.delete(any)).thenAnswer((_) async {});

        await datasource.toggleFavorite(testMovie);

        verify(mockBox.delete(testMovie.id)).called(1);
      },
    );

    test(
      'GIVEN a Hive exception WHEN toggling favorite THEN should throw LocalDatabaseException',
      () async {
        when(mockBox.put(any, any)).thenThrow(Exception('Hive error'));

        expect(
          () async => await datasource.toggleFavorite(testMovie),
          throwsA(isA<LocalDatabaseException>()),
        );
      },
    );
  });

  group('loadMovies', () {
    final testMovieMap = LocalMovieMapper.entityToMap(testMovie);

    test(
      'GIVEN stored movies WHEN loading THEN should return a list of movies',
      () async {
        when(mockBox.values).thenReturn([testMovieMap]);

        final result = await datasource.loadMovies();

        expect(result, isNotEmpty);
        expect(result.first, equals(testMovie));
        verify(mockBox.values).called(1);
      },
    );

    test(
      'GIVEN no stored movies WHEN loading THEN should return an empty list',
      () async {
        when(mockBox.values).thenReturn([]);

        final result = await datasource.loadMovies();

        expect(result, isEmpty);
        verify(mockBox.values).called(1);
      },
    );

    test(
      'GIVEN a Hive exception WHEN loading movies THEN should throw LocalDatabaseException',
      () async {
        when(mockBox.values).thenThrow(Exception('Hive error'));

        expect(
          () async => await datasource.loadMovies(),
          throwsA(isA<LocalDatabaseException>()),
        );
      },
    );
  });
}
