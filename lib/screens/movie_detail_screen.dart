import 'package:flutter/material.dart';

import '../providers/movies.dart';

class MovieDetailScreen extends StatelessWidget {
  static const routeName = '/movie-detail';
  // final Movie movie;
  // MovieDetailScreen({this.movie});
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments as Movie;

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 80.0),
        Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Expanded(flex: 1, child: levelIndicator),
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  movie.runtime.toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: NetworkImage(movie.medium_cover_image),
                // image: new AssetImage("drive-steering-wheel.jpg"),
                fit: BoxFit.cover,
              ),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      movie.summary,
      style: TextStyle(fontSize: 18.0),
    );

    final bottomContent = Container(
      // height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText],
        ),
      ),
    );

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
                  movie.medium_cover_image,
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
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    movie.summary,
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // body: Column(
      //   children: <Widget>[
      //     topContent,
      //     bottomContent,
      //   ],
      // ),
    );
  }
}
