import 'package:cinepedia/config/constants/enviroment.dart';
import 'package:cinepedia/domain/datasources/movies_datasource.dart';
import 'package:cinepedia/domain/entities/movie.dart';
import 'package:cinepedia/infrastructure/mappers/moviedb_mapper.dart';
import 'package:cinepedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDataSource{
// Siempre que use esa instancia dio todas las peticiones van a tener esa base de url precargada.
  final dio = Dio(
    BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        'api_key': Enviroment.theMovieDbKey,
        'language': "es-MX"
      }
    )
  );

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    
    final response = await dio.get("/movie/now_playing");
    // cuando haga la solicitud debo procesarla con mi entidad para que mi data funcione bien.
    final movieDBResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != "no-poster")
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
    }
  
}