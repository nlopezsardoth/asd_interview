import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';
import 'package:movies_module/data/datasources/moviedb_datasource_impl.dart';
import 'package:movies_module/data/models/moviedb/movie_details.dart';
import 'package:movies_module/data/models/moviedb/credits_response.dart';
import 'package:movies_module/data/models/moviedb/movie_moviedb.dart';
import 'package:movies_module/data/models/moviedb/moviedb_response.dart';
import 'package:movies_module/domain/entities/actor.dart';
import 'package:movies_module/domain/entities/movie.dart';

import '../mocks/dio_mock_helper.mocks.dart';


void main() {
  late MockDio mockDio;
  late MoviedbDatasourceImpl datasource;

  setUp(() {
    mockDio = MockDio();
    datasource = MoviedbDatasourceImpl(dio: mockDio);
  });

  final MovieMovieDB testMovie = MovieMovieDB(
    adult: false,
    backdropPath: '/test.jpg',
    genreIds: [1, 2],
    id: 123,
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
  final Cast testCast = Cast(
    adult: true,
    gender: 1,
    id: 123,
    knownForDepartment: "",
    name: "",
    originalName: "",
    popularity: 7.5,
    creditId: "",
  );

  test(
    'should return a list of movies when the request is successful',
    () async {
      // Arrange
      when(
        mockDio.get(any, queryParameters: anyNamed('queryParameters')),
      ).thenAnswer(
        (_) async => Response(
          data:
              MovieDbResponse(
                dates: null,
                page: 1,
                totalPages: 1,
                totalResults: 1,
                results: [testMovie],
              ).toJson(),
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      // Act
      final result = await datasource.getNowPlaying();

      // Assert
      expect(result, isA<List<Movie>>());
    },
  );

  test('should return a movie when the request is successful', () async {
    // Arrange
    when(mockDio.get(any)).thenAnswer(
      (_) async => Response(
        data:
            MovieDetails(
              adult: true,
              backdropPath: "path",
              belongsToCollection: BelongsToCollection(
                id: 123,
                name: "name",
                posterPath: "path",
                backdropPath: "path",
              ),
              budget: 123,
              genres: [Genre(id: 1, name: "name")],
              homepage: "homepage",
              id: 123,
              imdbId: "imdbId",
              originalLanguage: "originalLanguage",
              originalTitle: "originalTitle",
              overview: "overview",
              popularity: 2.5,
              posterPath: "posterPath",
              productionCompanies: [
                ProductionCompany(
                  id: 123,
                  logoPath: "logoPath",
                  name: "name",
                  originCountry: "originCountry",
                ),
              ],
              productionCountries: [
                ProductionCountry(iso31661: "iso31661", name: "name"),
              ],
              releaseDate: DateTime.now(),
              revenue: 10000,
              runtime: 100,
              spokenLanguages: [
                SpokenLanguage(
                  englishName: "englishName",
                  iso6391: "iso6391",
                  name: "name",
                ),
              ],
              status: "status",
              tagline: "tagline",
              title: "title",
              video: true,
              voteAverage: 123,
              voteCount: 123,
            ).toJson(),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    // Act
    final result = await datasource.getMovieById(822119);

    // Assert
    expect(result, isA<Movie>());
  });

  test('should return a list of actors when request is successful', () async {
    // Arrange
    when(mockDio.get(any)).thenAnswer(
      (_) async => Response(
        data:
            CreditsResponse(
              id: 123,
              cast: [testCast],
              crew: [testCast],
            ).toJson(),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      ),
    );

    // Act
    final result = await datasource.getActorsByMovie(123);

    // Assert
    expect(result, isA<List<Actor>>());
  });
}
