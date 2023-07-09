import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_radar/domain/models/movie.dart';
import 'package:movie_radar/domain/repositories/movie_db_repository.dart';
import 'package:movie_radar/injector.dart';

final detailsMovieProvider =
    StateNotifierProvider<DetailsMapNotifier, Map<String, Movie>>((ref) {
  final MovieDbRepository movieDbRepository = injector<MovieDbRepository>();

  return DetailsMapNotifier(getMovie: movieDbRepository.getMovieById);
});

typedef GetMovieCallback = Future<Movie> Function(String movieId);

class DetailsMapNotifier extends StateNotifier<Map<String, Movie>> {
  DetailsMapNotifier({required this.getMovie}) : super({});

  final GetMovieCallback getMovie;

  Future<void> loadMovie(String movieId) async {
    if (state[movieId] != null) {
      return;
    } else {
      final movie = await getMovie(movieId);

      state = {...state, movieId: movie};
    }
  }
}
