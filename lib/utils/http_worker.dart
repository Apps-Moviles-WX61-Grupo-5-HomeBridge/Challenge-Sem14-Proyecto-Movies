import  'dart:convert';
import  'dart:io';
import  'package:app_movies/models/Movie.dart';
import  'package:http/http.dart' as http;

final class HttpWorker {
  //  @Variables
  final String mUrlBase     = "https://api.themoviedb.org/3/movie";
  final String mUrlUpcoming = "/upcoming?";
  final String mUrlKey      = "api_key=3cae426b920b29ed2fb1c0749f258325";
  final String mUrlPage     = "&page=";

  //  @Methods
  Future<List<Movie>> getMovies(String page) async {
    final String url = mUrlBase + mUrlUpcoming + mUrlKey + mUrlPage + page;

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == HttpStatus.ok) {
      final dynamic jsonResponse = json.decode(response.body);
      final List<dynamic> moviesMap = jsonResponse['results'];

      List<Movie> movies = moviesMap.map<Movie>((i) => Movie.fromJson(i)).toList();
      return movies;
    }

    return [];
  }
}