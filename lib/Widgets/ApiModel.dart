class Movie {
  final int id;
  final String title;
  final String backdropPath;
  final double voteAverage;

  Movie({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'] ?? 'Unknown Title',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }
}

class TVShow {
  final int id;
  final String name;
  final String posterPath;
  final double voteAverage;

  TVShow({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.voteAverage,
  });

  factory TVShow.fromJson(Map<String, dynamic> json) {
    return TVShow(
      id: json['id'],
      name: json['name'] ?? 'Unknown Name',
      posterPath: json['poster_path'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
    );
  }
}
