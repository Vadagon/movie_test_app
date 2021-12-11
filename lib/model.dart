class Movie {
  final String title;
  final String overview;
  final String poster;

  Movie({
    required this.title,
    required this.overview,
    required this.poster,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      poster: json['poster_path'] ?? '',
    );
  }
}
