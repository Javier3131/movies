import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import '../providers/movies.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/movie-detail';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final movie = args['movie'] as Movie;
    // final movieDetail = args['movieDetail'] as MovieDetail;

    // final Movie movie = ModalRoute.of(context).settings.arguments as Movie;
    // final moviesData = Provider.of<Movies>(context);
    // final movieProv = moviesData.movies;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 700,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: movie.id,
                child: Image.network(
                  movie.large_cover_image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(height: 10),
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    movie.year.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    movie.genres.map((e) => e.toString()).join(' / '),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/imdb.png',
                        height: 60,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        movie.rating,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Text(
                    movie.summary,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 40,
                //     right: 40,
                //     top: 20,
                //     bottom: 20,
                //   ),
                //   child: Image.network(
                //     movieDetail.large_screenshot_image1,
                //     fit: BoxFit.cover,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
