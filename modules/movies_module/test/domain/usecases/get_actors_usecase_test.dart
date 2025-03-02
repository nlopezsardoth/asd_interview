import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:movies_module/domain/entities/actor.dart';
import 'package:movies_module/domain/usecases/get_actors_usecase.dart';

import '../mocks/repositories_mock_helper.mocks.dart';

void main() {
  late GetActorsUseCase useCase;
  late MockActorsRepository mockRepository;

  setUp(() {
    mockRepository = MockActorsRepository();
    useCase = GetActorsUseCase(mockRepository);
  });

  const testMovieId = 123;

  final testActors = [
    Actor(
      id: 1,
      name: "Test Actor",
      profilePath: "/test.jpg",
      character: "Main Character",
    ),
  ];

  test('should return a list of actors from the repository', () async {
    when(mockRepository.getActorsByMovie(testMovieId))
        .thenAnswer((_) async => Right(testActors));

    final result = await useCase(testMovieId);

    expect(result, equals(Right(testActors)));
    verify(mockRepository.getActorsByMovie(testMovieId));
    verifyNoMoreInteractions(mockRepository);
  });

}
