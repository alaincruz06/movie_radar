import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_radar/domain/repositories/movie_db_repository.dart';
import 'package:movie_radar/presentation/app/lang/l10n.dart';
import 'package:movie_radar/presentation/pages/home_page/widgets/card_swiper.dart';
import 'package:movie_radar/presentation/providers/popular_movies_provider.dart';
import 'package:movie_radar/presentation/providers/configs_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({required this.movieDbRepository, super.key});

  final MovieDbRepository movieDbRepository;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    ref.read(popularMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final popularMovies = ref.watch(popularMoviesProvider);
    final bool isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.radar),
        title: Text(S.of(context).appName),
        actions: [
          IconButton(
            tooltip: S.of(context).theme,
            onPressed: () =>
                ref.read(isDarkModeProvider.notifier).state = !isDarkMode,
            icon: Icon(isDarkMode
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_outlined),
          ),
        ],
      ),
      body: popularMovies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : CustomCardSwiper(
              movies: popularMovies,
              loadNextPage: () =>
                  ref.read(popularMoviesProvider.notifier).loadNextPage(),
            ),
    );
  }
}
