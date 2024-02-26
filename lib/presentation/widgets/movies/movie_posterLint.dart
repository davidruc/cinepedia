import 'package:animate_do/animate_do.dart';
import 'package:cinepedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviePosterLink extends StatelessWidget {

  final Movie movie;
  const MoviePosterLink({
    super.key, 
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 100),
      child: GestureDetector(
        onTap: () => context.push('/home/0/movie/${movie.id}'),
        child: SizedBox(
          width: 180,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(movie.posterPath),
          ),
        ),
      ),
    );
  }
}