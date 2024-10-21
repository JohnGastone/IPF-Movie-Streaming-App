// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipfmoviestreaming/Screens/FilmScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ipfmoviestreaming/Widgets/ApiModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String apiKey = 'ba86efc390e57094a77b83946be6625c';
  List<Movie> trendingMovies = [];
  List<Movie> continueWatching = [];
  List<TVShow> trendingTVShows = [];

  bool isLoading = true;
  String error = '';

  final PageController _pageController =
      PageController(viewportFraction: 1.0, keepPage: true);

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    setState(() {
      isLoading = true;
      error = '';
    });

    try {
      await Future.wait([
        fetchTrendingMovies(),
        fetchContinueWatching(),
        fetchTrendingTVShows(),
      ]);
    } catch (e) {
      setState(() {
        error = 'An error occurred while fetching data. Please try again.';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchTrendingMovies() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/movie/day?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        trendingMovies = (data['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load trending movies');
    }
  }

  Future<void> fetchContinueWatching() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        continueWatching = (data['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load continue watching');
    }
  }

  Future<void> fetchTrendingTVShows() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/trending/tv/day?api_key=$apiKey'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        trendingTVShows = (data['results'] as List)
            .map((tvShowJson) => TVShow.fromJson(tvShowJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load trending TV shows');
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
                onPressed: fetchAllData,
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
              child: PageView.builder(
                padEnds: false,
                controller: _pageController,
                itemCount: trendingMovies.length,
                itemBuilder: (context, index) {
                  final movie = trendingMovies[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilmScreen(movieId: movie.id),
                        ),
                      );
                    },
                    child: Container(
                      width: screenWidth,
                      height: screenHeight * 0.35,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w500${movie.backdropPath}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenHeight * 0.1),
                            Container(
                              width: screenWidth * 0.3,
                              height: screenHeight * 0.05,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18)),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star, color: Colors.yellow),
                                  SizedBox(width: screenWidth * 0.03),
                                  Text(
                                    movie.voteAverage.toStringAsFixed(1),
                                    style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 248, 248, 248),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              movie.title,
                              style: GoogleFonts.poppins(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 248, 248, 248),
                              ),
                            ),
                            SizedBox(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.05,
                              child: FloatingActionButton(
                                backgroundColor:
                                    Color.fromARGB(255, 142, 0, 254),
                                onPressed: () {},
                                child: Icon(
                                  CupertinoIcons.play_fill,
                                  color: Color.fromARGB(255, 248, 248, 248),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            buildSectionContinueWatching("Continue Watching", continueWatching,
                screenHeight, screenWidth),
            InkWell(
              child: buildSectionTrendingTvShows(
                  "Trending Now", trendingTVShows, screenHeight, screenWidth),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSectionContinueWatching(String title, List<Movie> items,
      double screenHeight, double screenWidth) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: Color.fromARGB(255, 248, 248, 248),
                ),
              ),
              Icon(
                CupertinoIcons.forward,
                color: Color.fromARGB(255, 248, 248, 248),
              )
            ],
          ),
        ),
        SizedBox(
          height: screenHeight * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
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
                              'https://image.tmdb.org/t/p/w500${item.backdropPath}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: screenHeight * 0.04,
                          width: screenWidth * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16)),
                            color: Colors.black.withOpacity(0.6),
                          ),
                          child: Center(
                            child: Text(
                              item.title,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 248, 248, 248)),
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
                          Icons.close_rounded,
                          color: Color.fromARGB(255, 248, 248, 248),
                          size: 24,
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
    );
  }

  Widget buildSectionTrendingTvShows(String title, List<TVShow> items,
      double screenHeight, double screenWidth) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 25,
                  color: Color.fromARGB(255, 248, 248, 248),
                ),
              ),
              Icon(
                CupertinoIcons.forward,
                color: Color.fromARGB(255, 248, 248, 248),
              )
            ],
          ),
        ),
        SizedBox(
          height: screenHeight * 0.25,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FilmScreen(movieId: item.id),
                          ),
                        );
                      },
                      child: Container(
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${item.posterPath}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: screenHeight * 0.04,
                            width: screenWidth * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),
                                  bottomRight: Radius.circular(16)),
                              color: Colors.black.withOpacity(0.6),
                            ),
                            child: Center(
                              child: Text(
                                item.name,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 248, 248, 248)),
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
    );
  }
}
