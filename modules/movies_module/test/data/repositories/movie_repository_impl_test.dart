import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_module/data/repositories/movie_repository_impl.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/repositories/movie_repository.dart';

import '../mocks/datasource_mock_helper.mocks.dart';

void main() {
  late MovieRepositoryImpl repository;
  late MockMoviedbDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockMoviedbDatasource();
    repository = MovieRepositoryImpl(datasource: mockDatasource);
  });

  final testMovie = Movie(
    adult: false,
    backdropPath: '/test.jpg',
    genreIds: ['Action', 'Adventure'],
    id: 1,
    originalLanguage: 'en',
    originalTitle: 'Test Movie',
    overview: 'A test movie overview.',
    popularity: 8.5,
    posterPath: '/test_poster.jpg',
    releaseDate: DateTime(2023, 12, 31),
    title: 'Spiderman',
    video: false,
    voteAverage: 7.5,
    voteCount: 1000,
  );
  final testMovies = [testMovie];

  group('getMovies', () {
    test(
      'GIVEN successful response WHEN calling getNowPlaying THEN returns movie list',
      () async {
        when(
          mockDatasource.getNowPlaying(page: anyNamed('page')),
        ).thenAnswer((_) async => testMovies);

        final result = await repository.getMovies(ListType.nowPlaying, 1);

        expect(result, equals(Right(testMovies)));
        verify(mockDatasource.getNowPlaying(page: anyNamed('page'))).called(1);
      },
    );
    test(
      'GIVEN successful response WHEN calling getPopular THEN returns movie list',
      () async {
        when(
          mockDatasource.getPopular(page: anyNamed('page')),
        ).thenAnswer((_) async => testMovies);

        final result = await repository.getMovies(ListType.popular, 1);

        expect(result, equals(Right(testMovies)));
        verify(mockDatasource.getPopular(page: anyNamed('page'))).called(1);
      },
    );
    test(
      'GIVEN successful response WHEN calling getTopRated THEN returns movie list',
      () async {
        when(
          mockDatasource.getTopRated(page: anyNamed('page')),
        ).thenAnswer((_) async => testMovies);

        final result = await repository.getMovies(ListType.topRated, 1);

        expect(result, equals(Right(testMovies)));
        verify(mockDatasource.getTopRated(page: anyNamed('page'))).called(1);
      },
    );
    test(
      'GIVEN successful response WHEN calling getUpcoming THEN returns movie list',
      () async {
        when(
          mockDatasource.getUpcoming(page: anyNamed('page')),
        ).thenAnswer((_) async => testMovies);

        final result = await repository.getMovies(ListType.upcoming, 1);

        expect(result, equals(Right(testMovies)));
        verify(mockDatasource.getUpcoming(page: anyNamed('page'))).called(1);
      },
    );
  });

  group('getMovieDetails', () {
    test(
      'GIVEN successful response WHEN calling getMovieById THEN returns movie',
      () async {
        when(
          mockDatasource.getMovieById(testMovie.id),
        ).thenAnswer((_) async => testMovie);

        final result = await repository.getMovieDetails(testMovie.id);

        expect(result, equals(Right(testMovie)));
        verify(mockDatasource.getMovieById(testMovie.id)).called(1);
      },
    );
  });

  group('searchMovies', () {
    const testQuery = 'Spiderman';
    test(
      'GIVEN successful response WHEN calling searchMovies THEN returns movie list',
      () async {
        when(
          mockDatasource.searchMovies(testQuery),
        ).thenAnswer((_) async => testMovies);

        final result = await repository.searchMovies(testQuery);

        expect(result, equals(Right(testMovies)));
        verify(mockDatasource.searchMovies(testQuery)).called(1);
      },
    );
  });
}
