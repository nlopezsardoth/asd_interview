import 'package:dartz/dartz.dart';
import 'package:shared_module/data/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;