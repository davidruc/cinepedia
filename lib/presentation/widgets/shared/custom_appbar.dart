import 'package:cinepedia/domain/entities/movie.dart';
import 'package:cinepedia/presentation/delegates/search_movie_delegate.dart';
import 'package:cinepedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10), 
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Icon(Icons.movie_outlined, color: colors.primary),
              const SizedBox( width: 6),
              Text("Cinemapedia", style: titleStyle,),
      
              //? Toma todo el espacio disponible entre los widgets
              const Spacer(),
      
              IconButton(
                onPressed: (){

                   final searchedMovies = ref.read( searchedMoviesProvider );
                  final searchQuery = ref.read( searchQueryProvider );

                  showSearch<Movie?>(
                    query: searchQuery,
                    context: context, 
                    delegate: SearchMovieDelegate(
                      initialMovies: searchedMovies,
                      searchMovie: ref.read( searchedMoviesProvider.notifier).searchMoviesByQuery
                    )
                  ).then((movie) {
                    if(movie == null) return;
                    context.push('/home/0/movie/${movie.id}');
                  });
                }, 
                icon: const Icon(Icons.search))
            ],
          ),
        ),
      ),
    );  
  }
}