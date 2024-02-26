
import 'package:cinepedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinepedia/domain/entities/movie.dart';
import 'package:cinepedia/domain/repositories/local_storage_repositoy.dart';

class LocalStorageRepositoryImpl extends LocalStorageRepository {

  final LocalStorageDataSource dataSource;

  LocalStorageRepositoryImpl(this.dataSource);

  @override
  Future<bool> isMovieFavorite(int movieId) {
    return dataSource.isMovieFavorite(movieId);
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return dataSource.loadMovies(limit: limit, offset: offset);
  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    return dataSource.toggleFavorite(movie);
  }

}