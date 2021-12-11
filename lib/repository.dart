import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:movie_test_app/api.dart';
import 'package:movie_test_app/model.dart';

Future<List<Movie>> getMovies() async {
  List<Movie> movies;
  List? jsonMovies;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  dynamic dbValue = prefs.getString('movies4');
  if (dbValue.runtimeType == String) {
    jsonMovies = jsonDecode(dbValue!);
  } else {
    await fetchMovies().then((value) {
      jsonMovies = value;
      prefs.setString('movies4', json.encode(jsonMovies));
    }).catchError((onError) => throw Exception('Failed to load Movie'));
  }
  movies = jsonMovies!.map<Movie>((e) => Movie.fromJson(e)).toList();
  return movies;
}
