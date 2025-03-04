import 'package:favorites_module/domain/usecases/is_movie_favorite_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import '../mocks/repositories_mock_helper.mocks.dart';

void main() {
  late IsMovieFavoriteUseCase useCase;
  late MockFavoritesRepository mockRepository;

  setUp(() {
    mockRepository = MockFavoritesRepository();
    useCase = IsMovieFavoriteUseCase(mockRepository);
  });

  const movieId = 123;

  test('should return true when movie is favorite', () async {
    when(mockRepository.isMovieFavorite(movieId))
        .thenAnswer((_) async => const Right(true));

    final result = await useCase(movieId);

    expect(result, const Right(true));
    verify(mockRepository.isMovieFavorite(movieId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return false when movie is not favorite', () async {
    when(mockRepository.isMovieFavorite(movieId))
        .thenAnswer((_) async => const Right(false));

    final result = await useCase(movieId);

    expect(result, const Right(false));
    verify(mockRepository.isMovieFavorite(movieId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
