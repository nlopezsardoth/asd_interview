import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/usecases/search_movies_usecase.dart';

import '../mocks/repositories_mock_helper.mocks.dart';

void main() {
  late SearchMoviesUseCase usecase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    usecase = SearchMoviesUseCase(mockRepository);
  });

  const testQuery = "Avengers";
  final testMovies = [Movie(
    id: 123,
    title: "Avengers",
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
  )];

  test('should return a list of movies matching the search query', () async {
    when(mockRepository.searchMovies(testQuery)).thenAnswer((_) async => Right(testMovies));

    final result = await usecase(testQuery);

    expect(result, equals(Right(testMovies)));
    verify(mockRepository.searchMovies(testQuery));
    verifyNoMoreInteractions(mockRepository);
  });
}
