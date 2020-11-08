import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/movies.dart';

class MovieItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<Movie>(context, listen: false);
    return InkWell(
      onTap: () {},
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Image.network(movie.medium_cover_image),
        ),
        footer: GridTileBar(
          title: Text(movie.title),
        ),
      ),
    );
  }
}
