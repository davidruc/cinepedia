import 'package:cinepedia/domain/entities/movie.dart';
import 'package:cinepedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final searchQueryProvider = StateProvider<String>((ref) => "");

final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref) {
  final movieRepository = ref.read( movieRepositoryProvider);
  return SearchedMoviesNotifier(
    ref: ref, 
    searchMovies: movieRepository.searchMovies,
  );
}); 

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {

  SearchedMoviesNotifier({required this.ref ,required this.searchMovies}): super([]);

  SearchMoviesCallback searchMovies;
  final Ref ref;

  Future<List<Movie>> searchMoviesByQuery(String query) async {
    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;
    return movies;
  }
}