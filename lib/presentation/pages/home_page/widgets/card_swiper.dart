import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_radar/domain/models/movie.dart';

class CustomCardSwiper extends StatefulWidget {
  const CustomCardSwiper({required this.movies, this.loadNextPage, super.key});

  final List<Movie> movies;
  final VoidCallback? loadNextPage;

  @override
  State<CustomCardSwiper> createState() => _CustomCardSwiperState();
}

class _CustomCardSwiperState extends State<CustomCardSwiper> {
  final CardSwiperController controller = CardSwiperController();
  late List<ExampleCard> cards = [];

  @override
  void initState() {
    super.initState();
    cards = widget.movies.map((e) => ExampleCard(e)).toList();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CardSwiper(
      controller: controller,
      onSwipe: (previousIndex, currentIndex, direction) {
        cards = widget.movies.map((e) => ExampleCard(e)).toList();
        if (widget.movies.length - previousIndex == 5 &&
            widget.loadNextPage != null) {
          widget.loadNextPage!();
        }
        return true;
      },
      isLoop: false,
      cardsCount: widget.movies.length,
      backCardOffset: const Offset(40, 40),
      cardBuilder: (context, index, percentThresholdX, percentThresholdY) =>
          cards[index],
    );
  }
}

class ExampleCard extends StatelessWidget {
  final Movie movie;

  const ExampleCard(
    this.movie, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/movie/${movie.id}'),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).iconTheme.color!,
                blurRadius: 10,
                offset: const Offset(0, 5))
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Stack(
            children: [
              Container(
                foregroundDecoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Theme.of(context).cardColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0, 1],
                  ),
                ),
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.fill,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      return const SizedBox();
                    } else {
                      return FadeIn(child: child);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 40),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      movie.title,
                      style: TextStyle(
                          color: Theme.of(context).iconTheme.color,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0, bottom: 10),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star_border,
                          color: Colors.yellowAccent,
                        ),
                        Text(
                          '${movie.voteAverage.toString()}/10',
                          style: TextStyle(
                              color: Theme.of(context).iconTheme.color,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
