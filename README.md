# Movie Streaming App

## Overview
This is a Flutter-based movie streaming app that fetches data from the TMDb (The Movie Database) API. The app allows users to browse movies, view detailed information about films, and explore actor profiles.

## Features
- **Google Authentication** for user sign-in and registration.
- **Home Screen** showcasing popular and trending movies and TV shows.
- **Movie Detail Screen** displaying comprehensive movie information.
- **Actor Profile Screen** showing actor details and their movie credits.
- **TMDb API Integration** to fetch real-time movie and actor data.

## Libraries Used
- **firebase_auth**: For user authentication via Google.
- **firebase_core**: Required for Firebase integration.
- **google_sign_in**: To handle Google sign-in functionality.
- **google_fonts**: To use custom fonts in the app.
- **http**: To fetch data from the TMDb API.
- **smooth_page_indicator**: For smooth page navigation, specifically in movie image carousels.

## Known Issues
- **Google Authentication Misconfiguration**: There were several misconfigurations encountered during setup, which may require revisiting and fixing.
- **Feature Limitation**: The proposed UI included additional features that were not covered by the TMDb API. As a result, they were excluded from the app.

## Installation Instructions
To run this project locally, follow these steps:

1. **Clone the repository**:
   git clone https://github.com/JohnGastone/IPF-Movie-Streaming-App.git
   

2. **Navigate to the project directory**:

   cd IPF-Movie-Streaming-App
  

3. **Install the necessary dependencies**:
   
   flutter pub get
   

4. **Run the project**:

   flutter run
   

## Additional Notes
- If Google authentication fails, you can bypass it by clicking the sign-up button to explore the app’s screens.
  


