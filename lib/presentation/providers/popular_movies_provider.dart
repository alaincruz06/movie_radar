import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_radar/domain/models/movie.dart';
import 'package:movie_radar/domain/repositories/movie_db_repository.dart';
import 'package:movie_radar/injector.dart';

final popularMoviesProvider =
    StateNotifierProvider<PopularMoviesNotifier, List<Movie>>((ref) {
  final MovieDbRepository movieDbRepository = injector<MovieDbRepository>();
  return PopularMoviesNotifier(fetchMoreMovies: movieDbRepository.getPopular);
});

typedef MovieCallback = Future<List<Movie>> Function({int page});

class PopularMoviesNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallback fetchMoreMovies;
  bool isLoading = false;

  PopularMoviesNotifier({
    required this.fetchMoreMovies,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
