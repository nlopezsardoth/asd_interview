import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_module/data/repositories/favorites_repository_impl.dart';
import 'package:movies_module/domain/entities/movie.dart';

import '../mocks/datasource_mock_helper.mocks.dart';
void main() {
  late FavoritesRepositoryImpl repository;
  late MockHiveDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockHiveDatasource();
    repository = FavoritesRepositoryImpl(datasource: mockDatasource);
  });

final testMovie = Movie(
    id: 123,
    title: "Test Movie",
    posterPath: "/test.jpg",
    overview: "Overview of test movie",
    releaseDate: DateTime.now(),
    voteAverage: 7.5,
    genreIds: ["28", "12"],
    backdropPath: "/backdrop.jpg",
    adult: false,
    originalLanguage: "en",
    originalTitle: "Test Movie Original",
    popularity: 100.0,
    video: false,
    voteCount: 500,
  );

  group('toogleFavorite', () {
    test(
      'GIVEN a valid movie WHEN toggling favorite THEN completes successfully',
      () async {
        when(mockDatasource.toggleFavorite(testMovie))
            .thenAnswer((_) async {});

        final result = await repository.toggleFavorite(testMovie);

        expect(result, equals(const Right(null)));
        verify(mockDatasource.toggleFavorite(testMovie)).called(1);
        verifyNoMoreInteractions(mockDatasource);
      },
    );
  });

  group('isMovieFavorite', () {
    test(
      'GIVEN a movie ID WHEN checking if it is favorite THEN returns result from datasource',
      () async {
        when(mockDatasource.isMovieFavorite(testMovie.id)).thenAnswer((_) async => true);

        final result = await repository.isMovieFavorite(testMovie.id);

        expect(result, equals(const Right(true)));
        verify(mockDatasource.isMovieFavorite(testMovie.id)).called(1);
        verifyNoMoreInteractions(mockDatasource);
      },
    );
  });

  group('getFavorites', () {
    test(
      'GIVEN a successful data retrieval WHEN calling getFavorites THEN returns a list of movies',
      () async {
        when(mockDatasource.loadMovies())
            .thenAnswer((_) async => [testMovie]);

        final result = await repository.getFavorites();

        expect(result, equals(Right([testMovie])));
        verify(mockDatasource.loadMovies()).called(1);
        verifyNoMoreInteractions(mockDatasource);
      },
    );
  });
}
