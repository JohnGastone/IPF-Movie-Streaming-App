// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipfmoviestreaming/Screens/ActorScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ipfmoviestreaming/Widgets/ApiModel.dart';

class FilmScreen extends StatefulWidget {
  final int movieId;

  const FilmScreen({super.key, required this.movieId});

  @override
  State<FilmScreen> createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  final String apiKey = 'ba86efc390e57094a77b83946be6625c';
  MovieDetails? movieDetails;
  bool isLoading = true;
  String error = '';

  @override
  void initState() {
    super.initState();
    fetchMovieDetails();
  }

  Future<void> fetchMovieDetails() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/${widget.movieId}?api_key=$apiKey&append_to_response=credits,reviews,similar'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          movieDetails = MovieDetails.fromJson(data);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      setState(() {
        error = 'An error occurred while fetching movie details: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (isLoading) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 40, 48, 61),
        body: Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 142, 0, 254),
          ),
        ),
      );
    }

    if (error.isNotEmpty) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 40, 48, 61),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                error,
                style: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 248, 248, 248),
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchMovieDetails,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 142, 0, 254),
                ),
                child: Text(
                  'Retry',
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 48, 61),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.4,
              width: screenWidth,
              child: movieDetails != null
                  ? Container(
                      height: screenHeight * 0.35,
                      width: screenWidth,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${movieDetails!.backdropPath}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 28.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    height: screenHeight * 0.03,
                                    width: screenWidth * 0.1,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back_ios_new,
                                      color: Color.fromARGB(255, 248, 248, 248),
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.15),
                            Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.55,
                                  height: screenHeight * 0.05,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18)),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      SizedBox(width: screenWidth * 0.03),
                                      Text(
                                        "${movieDetails!.voteAverage.toStringAsFixed(1)} ",
                                        style: GoogleFonts.poppins(
                                          color: Color.fromARGB(
                                              255, 248, 248, 248),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.2),
                              ],
                            ),
                            Container(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.05,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 142, 0, 254),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: screenHeight * 0.05,
                                    width: screenWidth * 0.45,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(18),
                                        bottomLeft: Radius.circular(18),
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Icon(
                                            CupertinoIcons.play_fill,
                                            color: Color.fromARGB(
                                                255, 248, 248, 248),
                                          ),
                                          Text(
                                            "Watch Now",
                                            style: GoogleFonts.poppins(
                                                color: Color.fromARGB(
                                                    255, 248, 248, 248)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: screenHeight * 0.05,
                                    width: screenWidth * 0.45,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 248, 248, 248),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(18),
                                        bottomRight: Radius.circular(18),
                                      ),
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            "./assets/cinema.png",
                                            color: Color.fromARGB(
                                                255, 142, 0, 254),
                                            height: screenHeight * 0.06,
                                            width: screenWidth * 0.07,
                                          ),
                                          Text(
                                            "Watch Trailer",
                                            style: GoogleFonts.poppins(
                                              color: Color.fromARGB(
                                                  255, 142, 0, 254),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movieDetails!.title,
                    style: GoogleFonts.poppins(
                      color: Color.fromARGB(255, 248, 248, 248),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    movieDetails!.overview,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 248, 248, 248)),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: screenWidth * 0.45,
                              height: screenHeight * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.black26.withOpacity(0.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        CupertinoIcons.hand_thumbsup,
                                        color:
                                            Color.fromARGB(255, 248, 248, 248),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Text(
                                        "254",
                                        style: GoogleFonts.poppins(
                                          color: Color.fromARGB(255, 40, 48,
                                              61), // White text color
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "   |   ",
                                    style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 40, 48, 61),
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        CupertinoIcons.hand_thumbsdown,
                                        color:
                                            Color.fromARGB(255, 248, 248, 248),
                                      ),
                                      SizedBox(width: screenWidth * 0.02),
                                      Text(
                                        "103",
                                        style: GoogleFonts.poppins(
                                          color: Color.fromARGB(255, 40, 48,
                                              61), // White text color
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: screenHeight * 0.03,
                              width: screenWidth * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              child: Icon(
                                Icons.bookmark_add,
                                color: Color.fromARGB(255, 248, 248, 248),
                                size: 15,
                              ),
                            ),
                            Container(
                              height: screenHeight * 0.03,
                              width: screenWidth * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              child: Icon(
                                CupertinoIcons.share,
                                color: Color.fromARGB(255, 248, 248, 248),
                                size: 15,
                              ),
                            ),
                            Container(
                              height: screenHeight * 0.03,
                              width: screenWidth * 0.1,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 142, 0, 254),
                              ),
                              child: Icon(
                                Icons.file_download_outlined,
                                color: Color.fromARGB(255, 248, 248, 248),
                                size: 15,
                              ),
                            ),
                          ],
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Cast & Crew",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Color.fromARGB(255, 248, 248, 248),
                              ),
                            ),
                            Icon(
                              CupertinoIcons.forward,
                              color: Color.fromARGB(255, 248, 248, 248),
                            )
                          ],
                        ),
                        SizedBox(
                          height: screenHeight * 0.18,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movieDetails?.cast.length ?? 0,
                            itemBuilder: (context, index) {
                              final actor = movieDetails!.cast[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ActorScreen(actorId: actor.id),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'https://image.tmdb.org/t/p/w200${actor.profilePath}',
                                        ),
                                        radius: 30,
                                      ),
                                      Text(
                                        actor.character,
                                        style: GoogleFonts.poppins(
                                            color: Color.fromARGB(
                                                255, 40, 48, 61)),
                                      ),
                                      Text(
                                        actor.name,
                                        style: GoogleFonts.poppins(
                                            color: Color.fromARGB(
                                                255, 248, 248, 248)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reviews",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                      Text(
                        "All reviews",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  movieDetails?.reviews.isNotEmpty ?? false
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: movieDetails!.reviews.length > 2
                              ? 2
                              : movieDetails!.reviews.length,
                          itemBuilder: (context, index) {
                            final review = movieDetails!.reviews[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 248, 248, 248)
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            review.avatarPath.isNotEmpty
                                                ? 'https://image.tmdb.org/t/p/w100${review.avatarPath}'
                                                : 'https://via.placeholder.com/100',
                                          ),
                                          radius: 20,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              review.author,
                                              style: GoogleFonts.poppins(
                                                color: Color.fromARGB(
                                                    255, 248, 248, 248),
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              review.createdAt.substring(0, 10),
                                              style: GoogleFonts.poppins(
                                                color: Color.fromARGB(
                                                    255, 40, 48, 61),
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      review.content.length > 100
                                          ? '${review.content.substring(0, 100)}...'
                                          : review.content,
                                      style: GoogleFonts.poppins(
                                          color: Color.fromARGB(
                                              255, 248, 248, 248)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'This movie has not received any review yet!',
                              style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 248, 248, 248),
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "More Like This",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          color: Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                      Icon(
                        CupertinoIcons.forward,
                        color: Color.fromARGB(255, 248, 248, 248),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movieDetails?.similarMovies.length ?? 0,
                      itemBuilder: (context, index) {
                        final movie = movieDetails!.similarMovies[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Stack(
                            children: [
                              Container(
                                width: screenWidth * 0.5,
                                height: screenHeight * 0.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: screenHeight * 0.08,
                                    width: screenWidth * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                      ),
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    child: Center(
                                      child: Text(
                                        movie.title,
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 248, 248, 248),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  height: screenHeight * 0.03,
                                  width: screenWidth * 0.1,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  child: Icon(
                                    Icons.bookmark_add,
                                    color: Color.fromARGB(255, 248, 248, 248),
                                    size: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
