import 'package:mockito/annotations.dart';
import 'package:movies_module/data/datasources/hive_datasource.dart';
import 'package:movies_module/data/datasources/moviedb_datasource.dart';

@GenerateMocks([MoviedbDatasource, HiveDatasource])
class DatasourceMockHelper {}
