import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'MOVIEDB_KEY', obfuscate: true)
  static String movieDbKey = _Env.movieDbKey;
}