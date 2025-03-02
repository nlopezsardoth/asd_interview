import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies_module/data/repositories/actors_repository_impl.dart';
import 'package:movies_module/domain/entities/actor.dart';

import '../mocks/datasource_mock_helper.mocks.dart';

void main() {
  late ActorsRepositoryImpl repository;
  late MockMoviedbDatasource mockDatasource;

  setUp(() {
    mockDatasource = MockMoviedbDatasource();
    repository = ActorsRepositoryImpl(datasource: mockDatasource);
  });

  group('getActorsByMovie', () {
    const testMovieId = 1;
    final testActor = Actor(
      id: 1,
      name: "Test Actor",
      profilePath: "/test.jpg",
      character: "Main Character",
    );
    final testActors = [
      testActor,
      testActor.copyWith(id: 2),
    ];

    test(
      'GIVEN a valid movie ID WHEN calling getActorsByMovie THEN should return list of actors',
      () async {
        when(mockDatasource.getActorsByMovie(testMovieId))
            .thenAnswer((_) async => testActors);

        final result = await repository.getActorsByMovie(testMovieId);

        expect(result, Right(testActors));
        verify(mockDatasource.getActorsByMovie(testMovieId)).called(1);
        verifyNoMoreInteractions(mockDatasource);
      },
    );
  });
}
