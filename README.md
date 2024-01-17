# Food Waste Flutter Application

## Overview
- This application enables a user to document daily food waste, consisting of a photo, number of leftover items, current date, and location of item(device).
- This project aims to showcase several mobile/flutter features implemented in the application. 
    - Invoke asynchronous methods, employ navigation, capture form data, and display data in ListView components and detail screens.
    - Demonstrate persistence with remote storage services, such as Firebase Cloud Storage and a Firestore database.
    - Obtain device location information and integrate the use of the camera or photo gallery.
    - Implement unit tests to validate application behavior.
    - Incorporate the Semantics widget to facilitate accessibility features of native platforms.
    - Demonstrate the use of analytics, crash reporting, and debugging tools. 

## Technology Stack
- Flutter
- Dart
- Google Firebase Cloud Storage
- Google in-app analytics

## Application Usage
### Main Screen 
- The user can see the list of posts uploaded in the application. 
- Number of total leftover items is shown on the top part of the screen. 
- User selects option(camera button) to make a new post.

<img src="https://github.com/AnnaBKC/Food-Waste-FlutterApp/blob/main/appScreenshots/list-of-posts.png" height=600>

### New Post Screen
- User selects an image from the camera or photo gallery, adds a number of leftover items, and submits the post.

<img src="https://github.com/AnnaBKC/Food-Waste-FlutterApp/blob/main/appScreenshots/create-new-post.png" height=600>

### Main Screen Updated
- The user is able to see the new post included on the main screen.
- User selects the first post in the list.

<img src="https://github.com/AnnaBKC/Food-Waste-FlutterApp/blob/main/appScreenshots/list-of-all-posts.png" height=600>

### Post Detail Screen
- User is able to see the details of the selected post:
    - Date
    - Image of leftover items
    - Amount of leftover items
    - Location of leftover items

<img src="https://github.com/AnnaBKC/Food-Waste-FlutterApp/blob/main/appScreenshots/post-detail-screen.png" height=600>
