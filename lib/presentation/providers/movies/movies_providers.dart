

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinepedia/domain/entities/movie.dart';
import 'package:cinepedia/presentation/providers/movies/movies_repository_provider.dart';

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying;
  
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies,
  );
});


typedef MovieCallback = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;

  //? vamos a controlar las peticiones, creamos una bandera booleana y evitamos que mientras carga la petición haga más y más.

  bool isLoading = false; 

  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies,
  }): super([]);

  Future<void> loadNextPage() async{
    if(isLoading ) return;

    isLoading = true;
    currentPage++;
    //Modificar un state.
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }



}
