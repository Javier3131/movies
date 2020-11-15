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
        title: Text(
          'Movies',
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
