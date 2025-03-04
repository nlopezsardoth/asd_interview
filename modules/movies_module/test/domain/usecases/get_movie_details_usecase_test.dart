import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:movies_module/domain/usecases/get_movie_detail_usecase.dart';

import '../mocks/repositories_mock_helper.mocks.dart';

void main() {
  late GetMovieDetailsUseCase useCase;
  late MockMovieRepository mockRepository;

  setUp(() {
    mockRepository = MockMovieRepository();
    useCase = GetMovieDetailsUseCase(mockRepository);
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
      title: 'Test Movie',
      video: false,
      voteAverage: 7.5,
      voteCount: 1000,
    );

  test('should return a list of movies from the repository', () async {
    when(mockRepository.getMovieDetails(testMovie.id))
        .thenAnswer((_) async => Right(testMovie));

    final result = await useCase(testMovie.id);

    expect(result, equals(Right(testMovie)));
    verify(mockRepository.getMovieDetails(testMovie.id));
    verifyNoMoreInteractions(mockRepository);
  });

}
