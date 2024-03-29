import 'package:cinepedia/domain/entities/movie.dart';
import 'package:cinepedia/infrastructure/models/moviedb/movie_details.dart';
import 'package:cinepedia/infrastructure/models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieFromMovieBD moviedb) => Movie(
      adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != "") 
        ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}' 
        : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
      genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}' 
        : 'https://viterbi-web.usc.edu/~zexunyao/itp301/Assignment_07/img.jpeg',
      releaseDate: moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(),
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
    );

  static Movie movieDetailsToEntity(MovieDetails moviedb ) => Movie(
    adult: moviedb.adult,
      backdropPath: (moviedb.backdropPath != "") 
        ? 'https://image.tmdb.org/t/p/w500/${moviedb.backdropPath}' 
        : 'https://static.vecteezy.com/system/resources/previews/005/337/799/original/icon-image-not-found-free-vector.jpg',
      genreIds: moviedb.genres.map((e) => e.name).toList(),
      id: moviedb.id,
      originalLanguage: moviedb.originalLanguage,
      originalTitle: moviedb.originalTitle,
      overview: moviedb.overview,
      popularity: moviedb.popularity,
      posterPath: (moviedb.posterPath != '')
        ? 'https://image.tmdb.org/t/p/w500/${moviedb.posterPath}' 
        : 'no-poster',
      releaseDate: moviedb.releaseDate,
      title: moviedb.title,
      video: moviedb.video,
      voteAverage: moviedb.voteAverage,
      voteCount: moviedb.voteCount
    );
}
