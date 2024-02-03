//? Este repositorio es inmutable, su objetivo es propocionar a todos los demás provider para que puedan consultar todo lo que proporciono en el movieRepositoryImpl
import 'package:cinepedia/infrastructure/dataSources/actor_moviedb_datasource.dart';
import 'package:cinepedia/infrastructure/repositories/actor_repository_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorsRepositoryProvider = Provider((ref) {
  return ActorRepositoryImpl( dataSource: ActorMoviedbDatasource());
});