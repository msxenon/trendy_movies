import 'package:flutter/material.dart';
import 'package:terndy_movies/application/localisation/keys.dart';
import 'package:terndy_movies/presentation/home/logic/movie_card_controller.dart';
import 'package:terndy_movies/presentation/home/ui/state_widget.dart';

class MovieCardStateWidget extends StatelessWidget {
  const MovieCardStateWidget({required this.state, Key? key}) : super(key: key);
  final MovieCardState state;
  @override
  Widget build(BuildContext context) {
    switch (state) {
      case MovieCardState.seen:
        return StateWidget(
          icon: Icons.local_movies_outlined,
          text: Keys.Actions_Movies_Seen.trans,
          bgColor: Colors.yellow,
        );

      case MovieCardState.never:
        return StateWidget(
          icon: Icons.close,
          text: Keys.Actions_Movies_Never.trans,
          bgColor: Colors.red,
        );

      case MovieCardState.watchList:
        return StateWidget(
          icon: Icons.favorite,
          text: Keys.Actions_Movies_Add_Wishlist.trans,
          bgColor: Colors.green,
        );

      case MovieCardState.maybeLater:
        return StateWidget(
          icon: Icons.watch_later_outlined,
          text: Keys.Actions_Movies_Maybe_Later.trans,
          bgColor: Colors.deepPurple,
        );
      case MovieCardState.defaultState:
        return const SizedBox.shrink();
    }
  }
}
