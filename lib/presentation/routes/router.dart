import 'package:go_router/go_router.dart';
import 'package:movie_radar/injector.dart';
import 'package:movie_radar/presentation/pages/details_page/details_page.dart';
import 'package:movie_radar/presentation/pages/home_page/home_page.dart';

// GoRouter configuration
final appRouter = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (context, state) => HomePage(
              movieDbRepository: injector(),
            ),
        routes: [
          GoRoute(
            path: 'movie/:id',
            builder: (context, state) {
              final movieId = state.pathParameters['id'] ?? 'no-id';
              return DetailsPage(movieId: movieId);
            },
          ),
        ]),
  ],
);
