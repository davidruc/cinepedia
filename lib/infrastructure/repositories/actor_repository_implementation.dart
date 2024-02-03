import 'package:cinepedia/domain/datasources/actors_datasource.dart';
import 'package:cinepedia/domain/entities/actor.dart';
import 'package:cinepedia/domain/repositories/actors_repositorie.dart';

class ActorRepositoryImpl extends ActorsRepository {

  final ActorsDataSource dataSource;

  ActorRepositoryImpl({required this.dataSource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) {
    return dataSource.getActorsByMovie(movieId); 
  }

}