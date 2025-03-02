import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/repositories/movie_repository.dart';
import 'package:movies_module/domain/usecases/get_movies_usecase.dart';

import '../mocks/repositories_mock_helper.mocks.dart';

void main() {
  late GetMoviesUseCase useCase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = GetMoviesUseCase(mockRepository);
  });

  final testMovies = [
    Movie(
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
      title: 'Test Movie',
      video: false,
      voteAverage: 7.5,
      voteCount: 1000,
    ),
  ];

  const testListType = ListType.popular;
  const testPage = 1;

  test('should return a list of movies from the repository', () async {
    when(mockRepository.getMovies(testListType, testPage))
        .thenAnswer((_) async => Right(testMovies));

    final result = await useCase((testListType, testPage));

    expect(result, equals(Right(testMovies)));
    verify(mockRepository.getMovies(testListType, testPage));
    verifyNoMoreInteractions(mockRepository);
  });

}
