import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinepedia/infrastructure/dataSources/moviedb_datasource.dart';
import 'package:cinepedia/infrastructure/repositories/movie_repository_implementation.dart';

//? Este repositorio es inmutable, su objetivo es propocionar a todos los demás provider para que puedan consultar todo lo que proporciono en el movieRepositoryImpl
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl( datasource: MoviedbDatasource()) ;
});



