// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ActorScreen extends StatefulWidget {
  const ActorScreen({super.key});

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  final List<Map<String, dynamic>> movies = [
    {
      'title': 'Doctor Strange',
      'genres': 'Action | Adventure | Fantasy',
      'image': './assets/zoe1.jpeg'
    },
    {
      'title': 'See',
      'genres': 'Action | Drama | Thriller',
      'image': './assets/zoe2.jpeg'
    },
    {
      'title': 'Game of Thrones',
      'genres': 'Action | Thriller | Fantasy',
      'image': './assets/zoe3.jpeg'
    }
  ];
  final List<Map<String, String>> filmography = [
    {
      "thumbnail": "./assets/colombiana.jpeg",
      "title": "Colombiana",
      "role": "Cataleya"
    },
    {
      "thumbnail": "./assets/pirates.jpeg",
      "title": "Pirates of Caribean",
      "role": "Gamora"
    },
    {
      "thumbnail": "./assets/losers.jpeg",
      "title": "The Losers",
      "role": "Aisha"
    },
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
                padEnds: false,
                controller: _pageController,
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Container(
                    height: screenHeight * 0.35,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(movie['image']),
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
                                    color: Colors.white,
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
                                width: screenWidth * 0.35,
                                height: screenHeight * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: screenWidth * 0.03),
                                        Text(
                                          "Top 107 ",
                                          style: GoogleFonts.poppins(
                                            color: Colors
                                                .white, // White text color
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "IMDb",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.2,
                              ),
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
                        ],
                      ),
                    ),
                  );
                },
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
                      Row(
                        children: [
                          Text(
                            "Actress",
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              ".",
                              style: GoogleFonts.poppins(color: Colors.grey),
                            ),
                          ),
                          Text(
                            "Producer",
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              ".",
                              style: GoogleFonts.poppins(color: Colors.grey),
                            ),
                          ),
                          Text(
                            "Writer",
                            style: GoogleFonts.poppins(color: Colors.grey),
                          )
                        ],
                      ),
                      Text(
                        "June 19, 1978",
                        style: GoogleFonts.poppins(color: Colors.grey),
                      )
                    ],
                  ),
                  Text(
                    "Zoe Saldana",
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "Zoë Yadira Saldaña-Perego is an American actress. Known primarily for her work in science fiction film franchises, she has starred in four of the highest-grossing films of all time (Avatar, Avatar: The Way of Water, Avengers: Infinity War, and Avengers: Endgame). ",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Filmography",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
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
                    height:
                        screenHeight * 0.25, // Set the height of the video row
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filmography.length,
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
                                    image: AssetImage(
                                        filmography[index]["thumbnail"]!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: screenHeight * 0.06,
                                    width: screenWidth * 0.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(16),
                                          bottomRight: Radius.circular(16)),
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Role - ${filmography[index]["role"]!}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            filmography[index]["title"]!,
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 248, 248, 248)),
                                          ),
                                        ],
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
                  Text(
                    "Quick Facts",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  Row(
                    children: [
                      Text(
                        "Birth City: ",
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "Pasaic. ",
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.grey),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Birth Country: ",
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "United States. ",
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.grey),
                      )
                    ],
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
