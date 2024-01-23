
import 'package:cinepedia/domain/datasources/movies_datasource.dart';
import 'package:cinepedia/domain/entities/movie.dart';
import 'package:cinepedia/domain/repositories/movies_repositorie.dart';

class MovieRepositoryImpl extends MoviesRepository{

  final MoviesDataSource datasource;

  MovieRepositoryImpl({required this.datasource}); 
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }

}