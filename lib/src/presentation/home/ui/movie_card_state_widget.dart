import 'package:flutter/material.dart';
import 'package:trendy_movies/src/application/localisation/keys.dart';
import 'package:trendy_movies/src/application/models/movie_category.dart';
import 'package:trendy_movies/src/presentation/home/ui/state_widget.dart';

class MovieCardStateWidget extends StatelessWidget {
  const MovieCardStateWidget({required this.state, Key? key}) : super(key: key);
  final MovieCategory? state;
  @override
  Widget build(BuildContext context) {
    switch (state) {
      case MovieCategory.seen:
        return StateWidget(
          icon: Icons.local_movies_outlined,
          text: Keys.Actions_Movies_Seen.trans,
          bgColor: Colors.yellow,
        );

      case MovieCategory.never:
        return StateWidget(
          icon: Icons.close,
          text: Keys.Actions_Movies_Never.trans,
          bgColor: Colors.red,
        );

      case MovieCategory.wishList:
        return StateWidget(
          icon: Icons.favorite,
          text: Keys.Actions_Movies_Add_Wishlist.trans,
          bgColor: Colors.green,
        );

      case MovieCategory.watchLater:
        return StateWidget(
          icon: Icons.watch_later_outlined,
          text: Keys.Actions_Movies_Maybe_Later.trans,
          bgColor: Colors.deepPurple,
        );
      case null:
        return const SizedBox.shrink();
    }
  }
}
