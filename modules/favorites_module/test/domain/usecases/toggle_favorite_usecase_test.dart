import 'package:favorites_module/domain/usecases/toggle_favorite_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:dartz/dartz.dart';


import '../mocks/repositories_mock_helper.mocks.dart';

void main() {
  late ToggleFavoriteUseCase useCase;
  late MockFavoritesRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoritesRepository();
    useCase = ToggleFavoriteUseCase(mockRepository);
  });

  final movie = Movie(
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

  test('should toggle favorite status successfully', () async {
    when(mockRepository.toggleFavorite(movie))
        .thenAnswer((_) async => const Right(null));

    final result = await useCase(movie);

    expect(result, const Right(null));
    verify(mockRepository.toggleFavorite(movie)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
