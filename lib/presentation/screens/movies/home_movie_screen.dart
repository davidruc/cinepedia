import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinepedia/presentation/providers/providers.dart';
import 'package:cinepedia/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeView();
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlidesShow = ref.watch(moviesSlideshowProvider);

    return Material(
      child: Column(
        children: [
          const CustomAppbar(),

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
          
        ],
      ),
    );
  }
}
