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
  final List<dynamic> genres;
  final String summary;
  final String medium_cover_image;
  final String large_cover_image;
  final String background_image;
  final DateTime date_uploaded;
  final String rating;

  Movie({
    this.id,
    this.title,
    this.title_english,
    this.title_long,
    this.year,
    this.runtime,
    this.imdb_code,
    this.url,
    this.genres,
    this.summary,
    this.medium_cover_image,
    this.large_cover_image,
    this.background_image,
    this.date_uploaded,
    this.rating,
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
      genres: json['genres'] as List<dynamic>,
      summary: json['summary'],
      medium_cover_image: json['medium_cover_image'],
      large_cover_image: json['large_cover_image'],
      background_image: json['background_image'],
      date_uploaded: DateTime.parse(json['date_uploaded']),
      rating: json['rating'].toString(),
    );
  }
}

class Movies extends ChangeNotifier {
  List<Movie> _movies = [];

  List<Movie> get movies {
    return [..._movies];
  }

  Movie findById(int id) {
    return movies.firstWhere((movie) => movie.id == id);
  }

  Future<void> fectchAndSetMovies() async {
    final url =
        'https://yts.mx/api/v2/list_movies.json?limit=20&sort_by=download_count';

    try {
      final List<Movie> loadedMovies = [];

      final response = await http.get(url);
      final extratedData = json.decode(response.body) as Map<String, dynamic>;
      if (extratedData == null) {
        return;
      }

      var movies = jsonDecode(response.body)['data']['movies'] as List;
      movies.forEach((movieData) {
        Movie m = Movie.fromJson(movieData);
        loadedMovies.add(m);
      });

      _movies = loadedMovies;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
