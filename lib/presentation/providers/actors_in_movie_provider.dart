import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_radar/domain/models/actor.dart';
import 'package:movie_radar/domain/repositories/actors_movie_db_repository.dart';
import 'package:movie_radar/injector.dart';

final actorsMapProvider =
    StateNotifierProvider<ActorsMapNotifier, Map<String, List<Actor>>>((ref) {
  final ActorsMovieDbRepository actorsMovieDbRepository =
      injector<ActorsMovieDbRepository>();

  return ActorsMapNotifier(
      getActors: actorsMovieDbRepository.getActorsByMovieId);
});

typedef GetActorsCallback = Future<List<Actor>> Function(String movieId);

class ActorsMapNotifier extends StateNotifier<Map<String, List<Actor>>> {
  ActorsMapNotifier({required this.getActors}) : super({});

  final GetActorsCallback getActors;

  Future<void> loadActors(String movieId) async {
    if (state[movieId] != null) {
      return;
    } else {
      final List<Actor> actors = await getActors(movieId);

      state = {...state, movieId: actors};
    }
  }
}
