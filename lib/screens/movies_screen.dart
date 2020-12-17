import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_item.dart';
import '../providers/movies.dart';
import '../screens/movie_search_screen.dart';

class MoviesScreen extends StatelessWidget {
  Future<void> _refreshMovies(BuildContext context) async {
    await Provider.of<Movies>(context, listen: false).fectchAndSetMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Movie App',
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                // color: Utils().createMaterialColor(Color(0xFF6ac044)),
              ),
              onPressed: () {
                final moviesData = Provider.of<Movies>(context, listen: false);
                moviesData.clearSearchResults();
                Navigator.of(context).pushNamed(MovieSearchScreen.routeName);
              }),
          IconButton(
              icon: Icon(Icons.help),
              onPressed: () {
                showAboutDialog(
                    context: context,
                    applicationName: 'Movie App',
                    applicationVersion: '1.0.2',
                    applicationLegalese: 'Develop by Javier Lopez',
                    applicationIcon: Image.asset(
                      'assets/images/movieicon.png',
                      height: 60.0,
                    ),
                    children: [
                      Text(
                        'This app is meant to display what Flutter can do in a simple movie app. This app is using as a data source of movie the YTS API, you can go here to learn more https://yts.mx/api.',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'provider: ^4.3.2+2',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'intl: ^0.16.1',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'http: ^0.12.2',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'transparent_image: ^1.0.0',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'photo_view: ^0.10.2',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'youtube_player_flutter: ^7.0.0+7',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'cached_network_image: ^2.4.1',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ]);
              })
        ],
      ),
      body: FutureBuilder(
        future: _refreshMovies(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshMovies(context),
                    child: Consumer<Movies>(
                      builder: (ctx, moviesData, _) => GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.7,
                        ),
                        padding: const EdgeInsets.all(25),
                        itemCount: moviesData.movies.length,
                        itemBuilder: (ctx, i) => MovieItem(
                          id: moviesData.movies[i].id,
                          title: moviesData.movies[i].title,
                          imageUrl: moviesData.movies[i].large_cover_image,
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
