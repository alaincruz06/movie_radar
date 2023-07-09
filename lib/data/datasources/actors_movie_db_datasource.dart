import 'package:dio/dio.dart';
import 'package:movie_radar/data/actor_mapper.dart';
import 'package:movie_radar/data/entities/credits_response.dart';
import 'package:movie_radar/domain/models/actor.dart';
import 'package:movie_radar/env.dart';

class ActorMovieDbDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {'api_key': Env.apiKey, 'language': 'es-ES'}));

  Future<List<Actor>> getActorsByMovieId(String movieId) async {
    final response = await dio.get('/movie/$movieId/credits');

    final castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
        .map((cast) => ActorMapper.castToEntity(cast))
        .toList();

    return actors;
  }
}
