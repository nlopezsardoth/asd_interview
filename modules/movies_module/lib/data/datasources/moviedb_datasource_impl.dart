import 'dart:io';
import 'package:dio/dio.dart';
import 'package:movies_module/data/datasources/moviedb_datasource.dart';
import 'package:movies_module/data/mappers/movie_mapper.dart';
import 'package:movies_module/data/models/moviedb/movie_details.dart';
import 'package:movies_module/data/models/moviedb/moviedb_response.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:shared_module/core/environments/env.dart';
import 'package:shared_module/data/errors/exceptions.dart';
import 'package:shared_module/data/errors/failures.dart';
import 'package:shared_module/data/networking/dio_builder.dart';

class MoviedbDatasourceImpl extends MoviedbDatasource {
  final Dio _dio;
  MoviedbDatasourceImpl({Dio? dio})
    : _dio =
          dio ??
          DioBuilder.createDio(
            options: BaseOptions(
              baseUrl: "https://api.themoviedb.org/3",
              headers: {
                "accept": "application/json",
                "Authorization": "Bearer ${Env.movieDbAccessToken}",
              },
              queryParameters: {'api_key': Env.movieDbKey, 'language': 'es-MX'},
            ),
            interceptors: [
              LogInterceptor(logPrint: (o) => print(o.toString())),
            ],
          );

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies =
        movieDBResponse.results
            .where((moviedb) => moviedb.posterPath != 'no-poster')
            .map((moviedb) => MovieMapper.movieDBToEntity(moviedb))
            .toList();

    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );

      return _jsonToMovies(response.data);
    } on DioException catch (e) {
      throw ServerException(
        message: '${e.message} ${e.response}',
        statusCode: e.response?.statusCode ?? HttpStatus.serviceUnavailable,
      );
    } catch (e) {
      throw MoviesServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/popular',
        queryParameters: {'page': page},
      );

      return _jsonToMovies(response.data);
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException(
        message: '${e.message} ${e.response}',
        statusCode: e.response?.statusCode ?? HttpStatus.serviceUnavailable,
      );
    } catch (e) {
      throw MoviesServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );

      return _jsonToMovies(response.data);
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException(
        message: '${e.message} ${e.response}',
        statusCode: e.response?.statusCode ?? HttpStatus.serviceUnavailable,
      );
    } catch (e) {
      throw MoviesServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    try {
      final response = await _dio.get(
        '/movie/upcoming',
        queryParameters: {'page': page},
      );

      return _jsonToMovies(response.data);
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException(
        message: '${e.message} ${e.response}',
        statusCode: e.response?.statusCode ?? HttpStatus.serviceUnavailable,
      );
    } catch (e) {
      throw MoviesServerFailure(message: e.toString());
    }
  }

  @override
  Future<Movie> getMovieById(int id) async {
    try {
      final response = await _dio.get('/movie/$id');
      if (response.statusCode != 200) {
        throw MovieNotFoundException(message: id.toString());
      }

      final movieDetails = MovieDetails.fromJson(response.data);
      final Movie movie = MovieMapper.movieDetailsToEntity(movieDetails);
      return movie;
    } on DioException catch (e) {
      throw ServerException(
        message: '${e.message} ${e.response}',
        statusCode: e.response?.statusCode ?? HttpStatus.serviceUnavailable,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw MoviesServerFailure(message: e.toString());
    }
  }

  @override
  Future<List<Movie>> searchMovies(String query) async {
    try {
      if (query.isEmpty) return [];

      final response = await _dio.get(
        '/search/movie',
        queryParameters: {'query': query},
      );

      return _jsonToMovies(response.data);
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw ServerException(
        message: '${e.message} ${e.response}',
        statusCode: e.response?.statusCode ?? HttpStatus.serviceUnavailable,
      );
    } catch (e) {
      throw MoviesServerFailure(message: e.toString());
    }
  }

}
