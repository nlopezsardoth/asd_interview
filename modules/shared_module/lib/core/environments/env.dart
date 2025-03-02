import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env', obfuscate: true)
abstract class Env {
  @EnviedField(varName: 'MOVIEDB_KEY')
  static String movieDbKey = _Env.movieDbKey;
  
  @EnviedField(varName: 'MOVIEDB_ACCESSTOKEN',)
  static String movieDbAccessToken = _Env.movieDbAccessToken;
}