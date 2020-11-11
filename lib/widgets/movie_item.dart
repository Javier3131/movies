import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../screens/movie_detail_screen.dart';
import '../providers/movies.dart';

class MovieItem extends StatelessWidget {
  final int id;
  final String title;
  final String imageUrl;

  MovieItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: GestureDetector(
        onTap: () {
          final Movie movie =
              Provider.of<Movies>(context, listen: false).findById(id);

          // final movieDetail = await Provider.of<Movies>(context, listen: false)
          //     .getMovieDetail(id);

          Navigator.of(context)
              .pushNamed(MovieDetailScreen.routeName, arguments: {
            'movie': movie,
            // 'movieDetail': movieDetail,
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: Hero(
            tag: id,
            child: Stack(
              children: [
                Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                Center(
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: imageUrl,
                  ),
                ),
              ],
            ),
          ),
          // child: Image.network(imageUrl),
        ),
      ),
      // footer: GridTileBar(
      //   title: Text(title),
      // ),
    );
  }
}
