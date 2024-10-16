// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipfmoviestreaming/FilmScreen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of movies with their name, genres, and image paths
  final List<Map<String, dynamic>> movies = [
    {
      'title': 'Avatar',
      'genres': 'Action | Adventure | Fantasy',
      'image': './assets/avatar.jpeg'
    },
    {
      'title': 'See',
      'genres': 'Action | Drama | Thriller',
      'image': './assets/see.jpeg'
    },
    {
      'title': 'Game of Thrones',
      'genres': 'Action | Thriller | Fantasy',
      'image': './assets/got.jpeg'
    }
  ];

  final List<Map<String, String>> videos = [
    {"thumbnail": "./assets/stranger.jpeg", "duration": "1:26:53"},
    {"thumbnail": "./assets/see.jpeg", "duration": "2:10:21"},
    {"thumbnail": "./assets/got.jpeg", "duration": "1:58:17"},
    // Add more videos as needed
  ];

  final List<Map<String, String>> trending = [
    {"thumbnail": "./assets/heart.jpeg", "title": "Heart of Stone"},
    {"thumbnail": "./assets/wakanda.jpeg", "title": "Wakanda Forever"},
    {"thumbnail": "./assets/love.jpeg", "title": "Love Again"},
    // Add more videos as needed
  ];

  final PageController _pageController =
      PageController(viewportFraction: 1.0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 48, 61),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.4,
              width: screenWidth,
              child: PageView.builder(
                padEnds: false, // This removes padding at the start and end
                controller: _pageController,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FilmScreen(),
                        ),
                      );
                    },
                    child: Container(
                      // Ensure the container takes full screen width
                      width: screenWidth,
                      height: screenHeight * 0.35,
                      decoration: BoxDecoration(
                        // Use BoxFit.cover to cover the container
                        image: DecorationImage(
                          image: AssetImage(movie['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 14.0), // Adjust padding as needed
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: screenHeight * 0.1),
                            // Rating Container (Optional)
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
                                    "7.5",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Movie Title
                            Text(
                              movie['title'],
                              style: GoogleFonts.poppins(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 248, 248, 248),
                              ),
                            ),
                            // Movie Genres
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
                                      Text(
                                        movie['genres'],
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Page indicator for the movies
                                SmoothPageIndicator(
                                  controller: _pageController,
                                  count: movies.length,
                                  effect: ExpandingDotsEffect(
                                    dotColor: Colors.white,
                                    activeDotColor:
                                        Color.fromARGB(255, 142, 0, 254),
                                    dotHeight: 10,
                                    dotWidth: 10,
                                  ),
                                ),
                              ],
                            ),
                            // Play Button
                            SizedBox(
                              width: screenWidth * 0.9,
                              height: screenHeight * 0.05,
                              child: FloatingActionButton(
                                backgroundColor:
                                    Color.fromARGB(255, 142, 0, 254),
                                onPressed: () {
                                  // Action when the play button is pressed
                                },
                                child: Icon(
                                  CupertinoIcons.play_fill,
                                  color: Colors.white,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Continue Watching",
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Color.fromARGB(255, 248, 248, 248)),
                  ),
                  Icon(
                    CupertinoIcons.forward,
                    color: Color.fromARGB(255, 248, 248, 248),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.25, // Set the height of the video row
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: videos.length,
                itemBuilder: (context, index) {
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
                              image: AssetImage(videos[index]["thumbnail"]!),
                              fit: BoxFit.cover,
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
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 33,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 22.0),
                            child: Container(
                              width: screenWidth * 0.35,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 142, 0, 254),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 10,
                          right: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Positioned(
                                bottom: 40,
                                left: 10,
                                right: 10,
                                child: Icon(
                                  CupertinoIcons.play_fill,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                videos[index]["duration"]!,
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trending Now",
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        color: Color.fromARGB(255, 248, 248, 248)),
                  ),
                  Icon(
                    CupertinoIcons.forward,
                    color: Color.fromARGB(255, 248, 248, 248),
                  )
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.25, // Set the height of the video row
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: videos.length,
                itemBuilder: (context, index) {
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
                              image: AssetImage(trending[index]["thumbnail"]!),
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
                                  trending[index]["title"]!,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Color.fromARGB(255, 248, 248, 248)),
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
                              color: Colors.white,
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
    );
  }
}
