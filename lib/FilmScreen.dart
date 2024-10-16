// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FilmScreen extends StatefulWidget {
  const FilmScreen({super.key});

  @override
  State<FilmScreen> createState() => _FilmScreenState();
}

class _FilmScreenState extends State<FilmScreen> {
  // List of movies with their name, genres, and image paths
  final List<Map<String, dynamic>> movies = [
    {
      'title': 'Doctor Strange',
      'genres': 'Action | Adventure | Fantasy',
      'image': './assets/stranger.jpeg'
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

  final List<Map<String, dynamic>> casting = [
    {
      'Role': 'Actor',
      'firstName': 'Sam',
      'lastName': 'Worthington',
      'image': './assets/stranger.jpeg'
    },
    {
      'Role': 'Actress',
      'firstName': 'Zoe',
      'lastName': 'Saldana',
      'image': './assets/see.jpeg'
    },
    {
      'Role': 'Actor',
      'firstName': 'Stephen',
      'lastName': 'Lang',
      'image': './assets/got.jpeg'
    },
    {
      'Role': 'Actress',
      'firstName': 'Sigourney',
      'lastName': 'Weaver',
      'image': './assets/got.jpeg'
    }
  ];

  final List<Map<String, String>> morelikethis = [
    {"thumbnail": "./assets/heart.jpeg", "title": "Heart of Stone"},
    {"thumbnail": "./assets/wakanda.jpeg", "title": "Wakanda Forever"},
    {"thumbnail": "./assets/love.jpeg", "title": "Love Again"},
  ];

  final List<Map<String, dynamic>> reviews = [
    {
      'user': 'Paragon240',
      'date': '14.08.23',
      'content': 'Visually stunning and action packed but story is light',
      'rating': 6,
    },
    {
      'user': 'Paragon240',
      'date': '14.08.23',
      'content':
          "Possibly the longest movie I've ever watch in theater yet one of the most fascinating movie",
      'rating': 6,
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
                          SizedBox(height: screenHeight * 0.2),

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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        SizedBox(width: screenWidth * 0.03),
                                        Text(
                                          "7.5 | ",
                                          style: GoogleFonts.poppins(
                                            color: Colors
                                                .white, // White text color
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "2023 | 12+",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
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
                                  dotHeight: 12,
                                  dotWidth: 12,
                                ),
                              ),
                            ],
                          ),
                          // Play Button
                          Container(
                            width: screenWidth * 0.9,
                            height: screenHeight * 0.05,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 142, 0, 254),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(18))),
                            child: Row(
                              children: [
                                Container(
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(18),
                                          bottomLeft: Radius.circular(18))),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Icon(
                                          CupertinoIcons.play_fill,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Watch Now",
                                          style: GoogleFonts.poppins(
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: screenHeight * 0.05,
                                  width: screenWidth * 0.45,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(18),
                                          bottomRight: Radius.circular(18))),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          CupertinoIcons.play_fill,
                                          color:
                                              Color.fromARGB(255, 142, 0, 254),
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
                            "Action",
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
                            "Adventure",
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
                            "Fantasy",
                            style: GoogleFonts.poppins(color: Colors.grey),
                          )
                        ],
                      ),
                      Text(
                        "3h 12m",
                        style: GoogleFonts.poppins(color: Colors.grey),
                      )
                    ],
                  ),
                  Text(
                    "AVATAR: THE WAY OF WATER",
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "Jake Sully lives with his newfound family formed on the extrasolar moon Pandora. Once a famliar threat returns to finish what was previously started Jake must work with Jeytiri and the army of the Na'vi race to protect their home...More",
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
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
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: screenWidth * 0.02),
                                    Text(
                                      "254",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey, // White text color
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "   |   ",
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      CupertinoIcons.hand_thumbsdown,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: screenWidth * 0.02),
                                    Text(
                                      "103",
                                      style: GoogleFonts.poppins(
                                        color: Colors.grey, // White text color
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
                              color: Colors.white,
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
                              color: Colors.white,
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
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cast & Crew",
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
                    height: screenHeight *
                        0.18, // Increased height to accommodate split name
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: casting.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage(casting[index]['image']),
                                radius: 30,
                              ),
                              Text(
                                casting[index]['Role'],
                                style: GoogleFonts.poppins(color: Colors.grey),
                              ),
                              Text(
                                casting[index]['firstName'],
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              Text(
                                casting[index]['lastName'],
                                style: GoogleFonts.poppins(color: Colors.white),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Audio Track: ",
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "English, Polish, German, Spanish. ",
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.grey),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Subtitles: ",
                        style: GoogleFonts.poppins(
                            fontSize: 16, color: Colors.white),
                      ),
                      Text(
                        "English, Polish, Germany. ",
                        style: GoogleFonts.poppins(
                            fontSize: 14, color: Colors.grey),
                      )
                    ],
                  ),
                  SizedBox(
                    height: screenHeight * 0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reviews",
                        style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Color.fromARGB(255, 248, 248, 248)),
                      ),
                      Text(
                        "All reviews",
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Color.fromARGB(255, 248, 248, 248)),
                      ),
                    ],
                  ),
                  Column(
                    children: reviews
                        .map((review) => ReviewItem(review: review))
                        .toList(),
                  ),
                  SizedBox(
                    height: screenHeight * 0.015,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "More Like This",
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
                  SizedBox(
                    height:
                        screenHeight * 0.25, // Set the height of the video row
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: morelikethis.length,
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
                                        morelikethis[index]["thumbnail"]!),
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
                                        morelikethis[index]["title"]!,
                                        style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 248, 248, 248)),
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
            )
          ],
        ),
      ),
    );
  }
}

class ReviewItem extends StatelessWidget {
  final Map<String, dynamic> review;

  const ReviewItem({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                review['user'],
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Text(
                '• ${review['date']}',
                style: GoogleFonts.poppins(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            review['content'],
            style: GoogleFonts.poppins(
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 16),
              SizedBox(width: 4),
              Text(
                '${review['rating']}/10',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
