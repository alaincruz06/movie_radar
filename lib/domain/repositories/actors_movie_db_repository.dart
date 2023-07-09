import 'package:movie_radar/domain/models/actor.dart';

abstract class ActorsMovieDbRepository {
  Future<List<Actor>> getActorsByMovieId(String movieId);
}
