import 'package:favorites_module/domain/usecases/get_favorites_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_module/domain/entities/movie.dart';

import '../mocks/repositories_mock_helper.mocks.dart';

void main() {
  late GetFavoritesUseCase usecase;
  late MockFavoritesRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoritesRepository();
    usecase = GetFavoritesUseCase(mockRepository);
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

  final testMovies = [
    testMovie,
    testMovie.copyWith(id: 2, title: 'Another Movie'),
  ];

  test('should return a list of favorite movies', () async {
    when(mockRepository.getFavorites()).thenAnswer((_) async => Right(testMovies));

    final result = await usecase(null);

    expect(result, equals(Right(testMovies)));
    verify(mockRepository.getFavorites());
    verifyNoMoreInteractions(mockRepository);
  });

}
