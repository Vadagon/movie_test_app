import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_test_app/model.dart';

Future<List> fetchMovies() async {
  final response = await http.get(Uri.parse(
      'https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=33f3cf629308b46ddfc62c05e50db435'));

  if (response.statusCode == 200) {
    Map res = jsonDecode(response.body);
    if (res['results'] == null) throw Exception('Failed to load Movie');

    return res['results'];
  } else {
    throw Exception('Failed to load Movie');
  }
}
