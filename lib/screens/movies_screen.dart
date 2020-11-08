import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_item.dart';
import '../providers/movies.dart';

class MoviesScreen extends StatelessWidget {
  Future<void> _refreshMovies(BuildContext context) async {
    await Provider.of<Movies>(context, listen: false).fectchAndSetMovies();
  }

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<Movies>(context, listen: false);
    final movies = moviesData.movies;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      // body: GridView.builder(
      //   padding: const EdgeInsets.all(25),
      //   itemCount: movies.length,
      //   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      //     maxCrossAxisExtent: 200,
      //     crossAxisSpacing: 20,
      //     mainAxisSpacing: 20,
      //     childAspectRatio: 0.7,
      //   ),
      //   itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
      //     // create: (ctx) => products[i],
      //     value: movies[i],
      //     child: MovieItem(),
      //   ),
      // ),
      body: FutureBuilder(
        future: _refreshMovies(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshMovies(context),
                    child: SafeArea(
                      child: Material(
                        color: Colors.transparent,
                        child: DefaultTextStyle(
                          style: TextStyle(color: Colors.grey[100]),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Consumer<Movies>(
                              builder: (ctx, mealsData, _) => GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                  childAspectRatio: 0.7,
                                ),
                                padding: const EdgeInsets.all(25),
                                itemCount: movies.length,
                                itemBuilder: (ctx, i) =>
                                    ChangeNotifierProvider.value(
                                  // create: (ctx) => products[i],
                                  value: movies[i],
                                  child: MovieItem(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
