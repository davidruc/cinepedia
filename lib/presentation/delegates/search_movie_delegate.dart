


import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinepedia/config/helpers/human_formats.dart';
import 'package:cinepedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovie;
  List<Movie> initialMovies; 
  
  StreamController<List<Movie>> debouncedMovies = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();
  

  Timer? _debounceTimer;
  SearchMovieDelegate({ 
    required this.initialMovies,
    required this.searchMovie});

  void clearStreams(){
    debouncedMovies.close();
  }

 

  void _onQueryChanged( String query ){
    isLoadingStream.add(true);
    if( _debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 500), () async { 
      final movies = await searchMovie( query );
      initialMovies = movies;
      debouncedMovies.add(movies);
      isLoadingStream.add(false);
     });
  }


  Widget buildTesultsAndSuggestions() {
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovies.stream,
      builder: (context, snapshot) {
        
        final movies = snapshot.data ?? [];
        
        return ListView.builder(
          
          itemCount: movies.length,
          itemBuilder: (context, index) =>
            _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              }
            ),
        );
      });
  }

  @override
  String get searchFieldLabel => "Buscar película";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      
      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream, 
        builder: (context, snapshot) {
          if (snapshot.data ?? false) {
            return SpinPerfect(
              duration: const Duration( seconds: 20),
              spins: 10,
              infinite: true,
              child: const Icon( Icons.refresh)
              );
          }
          return FadeInRight(
            animate: query.isNotEmpty,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
              onPressed: () => query = "", 
              icon: const Icon(Icons.clear)
            ),
          );
        },
      ),
      

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null );
      } , 
      icon: const Icon(Icons.arrow_back_ios_new_rounded)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
     return buildTesultsAndSuggestions();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _onQueryChanged(query);
    return buildTesultsAndSuggestions();
  }

}


class _MovieItem extends StatelessWidget {
  const _MovieItem({required this.movie, required this.onMovieSelected});
  
  final Movie movie; 
  final Function onMovieSelected;

  @override
  Widget build(BuildContext context) {

    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          children: [
      
            //img
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  loadingBuilder:(context, child, loadingProgress) => FadeIn(child: child), 
                  movie.posterPath
                ),
              ),
            ), 
      
            const SizedBox(width: 10),
      
            //Description
            SizedBox(
              width: size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleMedium),
                  (movie.overview.length > 100)
                    ? Text('${movie.overview.substring(0,100)}...')
                    : Text(movie.overview),
      
                  Row(
                    children: [
                      Icon(Icons.star_border_sharp, color: Colors.yellow.shade800,),
                      Text(
                        HumanFormats.number(movie.voteAverage, 2),
                        style: textStyles.bodyMedium!.copyWith(
                          color: Colors.yellow.shade900
                        )
                      ),
                    ],
                  )
                ],
              ),
            )
      
          ],
        ),
      ),
    );
  }
}