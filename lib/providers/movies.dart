import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Movie extends ChangeNotifier {
  final int id;
  final String title;
  final String title_english;
  final String title_long;
  final int year;
  final int runtime;
  final String imdb_code;
  final String url;
  // final List<String> genres;
  final String summary;
  final String medium_cover_image;
  final String background_image;
  final DateTime date_uploaded;

  Movie({
    this.id,
    this.title,
    this.title_english,
    this.title_long,
    this.year,
    this.runtime,
    this.imdb_code,
    this.url,
    // this.genres,
    this.summary,
    this.medium_cover_image,
    this.background_image,
    this.date_uploaded,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      title_english: json['title_english'],
      title_long: json['title_long'],
      year: json['year'],
      runtime: json['runtime'],
      imdb_code: json['imdb_code'],
      url: json['url'],
      // genres: json['genres'],
      summary: json['summary'],
      medium_cover_image: json['medium_cover_image'],
      background_image: json['background_image'],
      date_uploaded: DateTime.parse(json['date_uploaded']),
    );
  }
}

class Movies extends ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movies {
    return [..._movies];
  }

  Future<void> fectchAndSetMovies() async {
    final url =
        'https://yts.mx/api/v2/list_movies.json?limit=20&sort_by=download_count';

    try {
      final List<Movie> loadedMovies = [];
      // final response = await http.get(url);
      // var jsonresponse = jsonDecode(response.body)['data']['movies'] as List;
      // jsonresponse.forEach((movieData) {
      //   print(movieData);
      //   Movie m = Movie.fromJson(movieData);
      // });

      final response = await http.get(url);
      final extratedData = json.decode(response.body) as Map<String, dynamic>;
      if (extratedData == null) {
        return;
      }

      // print(extratedData['data']);
      var movies = jsonDecode(response.body)['data']['movies'] as List;
      movies.forEach((movieData) {
        // print(movieData);
        Movie m = Movie.fromJson(movieData);
        loadedMovies.add(m);
      });

      // extratedData['data']['movies'].forEach((key, value) {
      //   final mealData = value;
      //   loadedMovies.add(Movie(
      //     id: mealData['id'],
      //     title: mealData['title'],
      //     title_english: mealData['title_english'],
      //     title_long: mealData['title_long'],
      //     year: mealData['year'],
      //     runtime: mealData['runtime'],
      //     imdb_code: mealData['imdb_code'],
      //     url: mealData['url'],
      //     // genres: mealData['genres'],
      //     summary: mealData['summary'],
      //     medium_cover_image: mealData['medium_cover_image'],
      //     background_image: mealData['background_image'],
      //     date_uploaded: mealData['date_uploaded'],
      //   ));
      // });

      _movies = loadedMovies;
      // _movies = [];
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
