import 'package:movie_radar/data/datasources/actors_movie_db_datasource.dart';
import 'package:movie_radar/domain/models/actor.dart';
import 'package:movie_radar/domain/repositories/actors_movie_db_repository.dart';

class ActorsMovieDbRepositoryImpl extends ActorsMovieDbRepository {
  ActorsMovieDbRepositoryImpl(this._actorMovieDbDatasource) : super();

  final ActorMovieDbDatasource _actorMovieDbDatasource;

  @override
  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    return _actorMovieDbDatasource.getActorsByMovieId(movieId);
  }
}
