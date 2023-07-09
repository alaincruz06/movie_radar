import 'package:movie_radar/domain/models/movie.dart';

abstract class MovieDbRepository {
  Future<List<Movie>> getPopular({int page = 1});

  Future<Movie> getMovieById(String id);
}
