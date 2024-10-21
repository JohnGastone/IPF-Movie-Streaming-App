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

class MovieDetails {
  final int id;
  final String title;
  final String backdropPath;
  final double voteAverage;
  final String overview;
  final List<Cast> cast;
  final List<Review> reviews;
  final List<Movie> similarMovies;

  MovieDetails({
    required this.id,
    required this.title,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.cast,
    required this.reviews,
    required this.similarMovies,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      id: json['id'],
      title: json['title'] ?? 'Unknown Title',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      overview: json['overview'] ?? 'No overview available',
      cast: (json['credits']['cast'] as List<dynamic>)
          .map((castJson) => Cast.fromJson(castJson))
          .toList(),
      reviews: (json['reviews']['results'] as List<dynamic>)
          .map((reviewJson) => Review.fromJson(reviewJson))
          .toList(),
      similarMovies: (json['similar']['results'] as List<dynamic>)
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList(),
    );
  }
}

class Cast {
  final int id;
  final String name;
  final String character;
  final String profilePath;

  Cast({
    required this.id,
    required this.name,
    required this.character,
    required this.profilePath,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'],
      name: json['name'] ?? 'Unknown Name',
      character: json['character'] ?? 'Unknown Character',
      profilePath: json['profile_path'] ?? '',
    );
  }
}

class Review {
  final String author;
  final String content;
  final String createdAt;
  final String avatarPath;

  Review({
    required this.author,
    required this.content,
    required this.createdAt,
    required this.avatarPath,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      author: json['author'] ?? 'Unknown Author',
      content: json['content'] ?? 'No content',
      createdAt: json['created_at'] ?? '',
      avatarPath: json['author_details']['avatar_path'] ?? '',
    );
  }
}

class ActorDetails {
  final int id;
  final String name;
  final String knownForDepartment;
  final String birthday;
  final String biography;
  final String placeOfBirth;
  final List<MovieCredit> movies;

  ActorDetails({
    required this.id,
    required this.name,
    required this.knownForDepartment,
    required this.birthday,
    required this.biography,
    required this.placeOfBirth,
    required this.movies,
  });

  factory ActorDetails.fromJson(
      Map<String, dynamic> json, List<dynamic> movieCredits) {
    return ActorDetails(
      id: json['id'],
      name: json['name'],
      knownForDepartment: json['known_for_department'],
      birthday: json['birthday'] ?? 'N/A',
      biography: json['biography'],
      placeOfBirth: json['place_of_birth'] ?? 'N/A',
      movies: List<MovieCredit>.from(
          movieCredits.map((movie) => MovieCredit.fromJson(movie))),
    );
  }
}

class MovieCredit {
  final int id;
  final String title;
  final String character;
  final String? posterPath;
  final String? backdropPath;

  MovieCredit({
    required this.id,
    required this.title,
    required this.character,
    this.posterPath,
    this.backdropPath,
  });

  factory MovieCredit.fromJson(Map<String, dynamic> json) {
    return MovieCredit(
      id: json['id'],
      title: json['title'],
      character: json['character'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
    );
  }
}
