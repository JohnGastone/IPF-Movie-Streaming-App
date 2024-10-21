// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ipfmoviestreaming/Widgets/ApiModel.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ActorScreen extends StatefulWidget {
  final int actorId;

  const ActorScreen({super.key, required this.actorId});

  @override
  State<ActorScreen> createState() => _ActorScreenState();
}

class _ActorScreenState extends State<ActorScreen> {
  final String apiKey = 'ba86efc390e57094a77b83946be6625c';
  ActorDetails? actorDetails;
  final PageController _pageController =
      PageController(viewportFraction: 1.0, keepPage: true);

  @override
  void initState() {
    super.initState();
    fetchActorDetails();
  }

  Future<void> fetchActorDetails() async {
    final detailsResponse = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/${widget.actorId}?api_key=$apiKey'));
    final creditsResponse = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/person/${widget.actorId}/movie_credits?api_key=$apiKey'));

    if (detailsResponse.statusCode == 200 &&
        creditsResponse.statusCode == 200) {
      final detailsJson = json.decode(detailsResponse.body);
      final creditsJson = json.decode(creditsResponse.body);
      setState(() {
        actorDetails = ActorDetails.fromJson(detailsJson, creditsJson['cast']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (actorDetails == null) {
      return Scaffold(
        backgroundColor: Color.fromARGB(255, 40, 48, 61),
        body: Center(child: CircularProgressIndicator()),
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
                itemCount: actorDetails!.movies.length > 3
                    ? 3
                    : actorDetails!.movies.length,
                itemBuilder: (context, index) {
                  final movie = actorDetails!.movies[index];
                  return Container(
                    height: screenHeight * 0.35,
                    width: screenWidth,
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
                                width: screenWidth * 0.35,
                                height: screenHeight * 0.05,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(18)),
                                ),
                                child: Center(
                                  child: Text(
                                    movie.title,
                                    style: GoogleFonts.poppins(
                                      color: Color.fromARGB(255, 248, 248, 248),
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.2),
                              SmoothPageIndicator(
                                controller: _pageController,
                                count: actorDetails!.movies.length > 3
                                    ? 3
                                    : actorDetails!.movies.length,
                                effect: ExpandingDotsEffect(
                                  dotColor: Color.fromARGB(255, 248, 248, 248),
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
                      Text(
                        actorDetails!.knownForDepartment,
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 40, 48, 61)),
                      ),
                      Text(
                        actorDetails!.birthday,
                        style: GoogleFonts.poppins(
                            color: Color.fromARGB(255, 40, 48, 61)),
                      ),
                    ],
                  ),
                  Text(
                    actorDetails!.name,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 248, 248, 248),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    actorDetails!.biography,
                    style: GoogleFonts.poppins(
                        color: Color.fromARGB(255, 248, 248, 248)),
                  ),
                  SizedBox(height: screenHeight * 0.01),
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
                    height: screenHeight * 0.28,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: actorDetails!.movies.length,
                      itemBuilder: (context, index) {
                        final movie = actorDetails!.movies[index];
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
                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
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
                                          bottomRight: Radius.circular(16)),
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Role - ${movie.character}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Color.fromARGB(
                                                    255, 40, 48, 61)),
                                          ),
                                          Text(
                                            movie.title,
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
                  Text(
                    "Quick Facts",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 248, 248, 248)),
                  ),
                  Row(
                    children: [
                      Text(
                        "Birth Place: ",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Color.fromARGB(255, 248, 248, 248)),
                      ),
                      Text(
                        actorDetails!.placeOfBirth,
                        style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color.fromARGB(255, 40, 48, 61)),
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
