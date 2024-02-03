import 'package:cinepedia/domain/entities/movie.dart';
import 'package:cinepedia/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieInfoProvider = StateNotifierProvider<MovieMapNotifier, Map<String, Movie>>((ref) {
  final movieRepostory = ref.watch( movieRepositoryProvider);

  return MovieMapNotifier(getMovie: movieRepostory.getMovieById);
}

);


typedef GetMovieCallBack = Future<Movie>Function(String movieId);

class MovieMapNotifier extends StateNotifier<Map<String, Movie>> {

  final GetMovieCallBack getMovie;

  MovieMapNotifier({required this.getMovie}): super({});

  Future<void> loadMovie(String movieId) async {
    if ( state[movieId] != null ) return; //*Así puedo evitar que si ya la tengo la vuelva a llamar
    final movie = await getMovie(movieId);

    state = { ...state, movieId: movie };
  }

}