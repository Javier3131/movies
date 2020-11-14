import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/image_view.dart';
import '../widgets/cast_item.dart';
import '../providers/movies.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/movie-detail';

  Future<void> _getMovieDetail(BuildContext context, int movieId) async {
    await Provider.of<Movies>(context, listen: false).getMovieDetail(movieId);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final movie = args['movie'] as Movie;

    Widget _genres() {
      return Padding(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Text(
          movie.genres.map((e) => e.toString()).join(' / '),
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );
    }

    Widget _imdb() {
      return Padding(
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
      );
    }

    Widget _imgView(String url) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ImageView.routeName, arguments: {
            'url': url,
            // 'movieDetail': movieDetail,
          });
        },
        child: Hero(
          tag: url,
          child: Image.network(
            url,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget _movieDetail() {
      return FutureBuilder(
        future: _getMovieDetail(context, movie.id),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _getMovieDetail(context, movie.id),
                    child: Consumer<Movies>(
                      builder: (ctx, moviesData, _) => Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ListView(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _imgView(moviesData
                                      .movieDetail.large_screenshot_image1),
                                  _imgView(moviesData
                                      .movieDetail.large_screenshot_image2),
                                  _imgView(moviesData
                                      .movieDetail.large_screenshot_image3),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: ListView.builder(
                                // padding: const EdgeInsets.all(5),
                                itemCount: moviesData.movieDetail.cast.length,
                                itemBuilder: (ctx, i) => CastItem(
                                  name: moviesData.movieDetail.cast[i].name,
                                  imdb_code:
                                      moviesData.movieDetail.cast[i].imdb_code,
                                  character_name: moviesData
                                      .movieDetail.cast[i].character_name,
                                  image_url: moviesData
                                      .movieDetail.cast[i].url_small_image,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 700,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movie.title),
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
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    movie.year.toString(),
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
                _genres(),
                SizedBox(height: 10),
                _imdb(),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Text(
                    movie.summary,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                _movieDetail(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
