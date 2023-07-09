import 'package:get_it/get_it.dart';
import 'package:movie_radar/data/datasources/actors_movie_db_datasource.dart';
import 'package:movie_radar/data/datasources/movie_db_datasource.dart';
import 'package:movie_radar/data/repositories_impl/actors_movie_db_repository_impl.dart';
import 'package:movie_radar/data/repositories_impl/movie_db_repository_impl.dart';
import 'package:movie_radar/domain/repositories/actors_movie_db_repository.dart';
import 'package:movie_radar/domain/repositories/movie_db_repository.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  //Datasources
  injector.registerLazySingleton<MoviedbDatasource>(
    () => MoviedbDatasource(),
  );
  injector.registerLazySingleton<ActorMovieDbDatasource>(
    () => ActorMovieDbDatasource(),
  );

  //Repositories
  injector.registerLazySingleton<MovieDbRepository>(
    () => MovieDbRepositoryImpl(injector<MoviedbDatasource>()),
  );
  injector.registerLazySingleton<ActorsMovieDbRepository>(
    () => ActorsMovieDbRepositoryImpl(injector<ActorMovieDbDatasource>()),
  );
}
