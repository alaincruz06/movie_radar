import 'package:movie_radar/data/datasources/movie_db_datasource.dart';
import 'package:movie_radar/domain/models/movie.dart';
import 'package:movie_radar/domain/repositories/movie_db_repository.dart';

class MovieDbRepositoryImpl extends MovieDbRepository {
  MovieDbRepositoryImpl(this._moviedbDatasource) : super();

  final MoviedbDatasource _moviedbDatasource;

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    return _moviedbDatasource.getPopular(page: page);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    return _moviedbDatasource.getMovieById(id);
  }
}
