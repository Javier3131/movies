import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_item.dart';
import '../providers/movies.dart';

class MovieSearchScreen extends StatelessWidget {
  static const routeName = '/movie-search';
  final _movieNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final moviesData = Provider.of<Movies>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Search Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextFormField(
              cursorColor: Colors.green,
              decoration: InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                labelText: 'Movie Name...',
                labelStyle: Theme.of(context).textTheme.bodyText1,
                // .merge(TextStyle(color: Colors.green)),
                // sty
              ),
              keyboardType: TextInputType.url,
              textInputAction: TextInputAction.done,
              controller: _movieNameController,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a movie name.';
                }
                return null;
              },
              onFieldSubmitted: (text) {
                print('On field submitted: ' + text);
                if (text.isEmpty) return;
                Provider.of<Movies>(context, listen: false).searchMovies(text);
              },
              onEditingComplete: () {
                print('finish editing');
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.7,
                ),
                padding: const EdgeInsets.all(25),
                itemCount: moviesData.searchResults.length,
                itemBuilder: (ctx, i) => MovieItem(
                  id: moviesData.searchResults[i].id,
                  title: moviesData.searchResults[i].title,
                  imageUrl: moviesData.searchResults[i].large_cover_image,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
