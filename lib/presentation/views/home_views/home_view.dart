import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinepedia/presentation/providers/providers.dart';

import '../../widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch( initialLoadingProvider);
    if( initialLoading ) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlidesShow = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch( popularMoviesProvider);
    final topRatedMovies = ref.watch( topRatedMoviesProvider);
    final upComingMovies = ref.watch( upComingMoviesProvider);
    

    return  CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppbar(),
          titlePadding: EdgeInsets.zero, // Ajusta esta línea
          centerTitle: false, // Ajusta esta línea
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Material(
          child: Column(
            children: [
             

              MoviesSlideshow(movies: moviesSlidesShow),
              // Expanded(
              //     child: ListView.builder(
              //       itemCount: nowPlayingMovies.length,
              //       itemBuilder: (context, index) {
              //         final movie = nowPlayingMovies[index];
              //         return ListTile(
              //           title: Text(movie.title),
              //         );
              //       },
              //     ),
              //   ),

              MoveHorizontalListview(
                movies: nowPlayingMovies,
                title: "En cines",
                subtitle: "lunes 20",
                loadNextPage: () {
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MoveHorizontalListview(
                movies: popularMovies,
                title: "Populares",
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                },
              ),
              MoveHorizontalListview(
                movies: upComingMovies,
                title: "Proximamente",
                subtitle: "Este mes",
                loadNextPage: () {
                  ref.read(upComingMoviesProvider.notifier).loadNextPage();
                },
              ),
              
              MoveHorizontalListview(
                movies: topRatedMovies,
                title: "Mejor calificadas",
                subtitle: "All time",
                loadNextPage: () {
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                },
              )
            ],
          ),
        );
      }, childCount: 1))
    ]);
  }
}
