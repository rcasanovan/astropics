# <img src="assets/icon.png" width="20" height="20"> astropics

This demo implements a very simple app to show the last seven(7) days pictures / videos from NASA.

The user can see the last pics / videos and go to a detail section.


## Architecture

"The Composable Architecture (TCA, for short) is a library for building applications in a consistent and understandable way, with composition, testing, and ergonomics in mind. It can be used in SwiftUI, UIKit, and more, and on any Apple platform (iOS, macOS, tvOS, and watchOS)".


## What is the Composable Architecture?

This library provides a few core tools that can be used to build applications of varying purpose and complexity. It provides compelling stories that you can follow to solve many problems you encounter day-to-day when building applications, such as:

* State management

How to manage the state of your application using simple value types, and share state across many screens so that mutations in one screen can be immediately observed in another screen.

* Composition

How to break down large features into smaller components that can be extracted to their own, isolated modules and be easily glued back together to form the feature.

* Side effects

How to let certain parts of the application talk to the outside world in the most testable and understandable way possible.

* Testing

How to not only test a feature built in the architecture, but also write integration tests for features that have been composed of many parts, and write end-to-end tests to understand how side effects influence your application. This allows you to make strong guarantees that your business logic is running in the way you expect.

* Ergonomics

How to accomplish all of the above in a simple API with as few concepts and moving parts as possible.


## Data flow
<p float="center">
  <img src="https://github.com/rcasanovan/astropics/blob/main/Images/TCA_image.001.jpeg"/>
</p>

## Assumptions
- Astronomy picture ID: In order to list all the astronomy pictures, we need to add an ID for each item. As the API is not retrieving an ID, I generated the ID for each tiem considering diferent fields (url, date, title an explanation).
- Astronomy picture image: The API is rerieving two fields for the image (one for the full size format and another for a medium size format). It would be nice to explore if the API could retrieve a customizable URL (just like https://apod.nasa.gov/apod/image/2401/image_W_H.jpg). This way we could control the size for the image and load it according to the size we need for each case (e.g.: for the list in the main view).
- Error view: I added an error view state just in case the API is retrieving an error for the call.
- Videos and Images: I detected that the API is retrieving images and videos. I'm considering this and changing the UI for each case.

## Snapshots - Astronomy Pictures view
<p float="left">
  <img src="https://github.com/rcasanovan/astropics/blob/main/Images/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-06-13%20at%2017.13.04.png" width="250" />
  <img src="https://github.com/rcasanovan/astropics/blob/main/Images/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-06-13%20at%2017.13.10.png" width="250" />
  <img src="https://github.com/rcasanovan/astropics/blob/main/Images/Simulator%20Screenshot%20-%20Clone%201%20of%20iPhone%2015%20Pro%20-%202024-08-20%20at%2022.57.14.png" width="250" />
  <img src="https://github.com/rcasanovan/astropics/blob/main/Images/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-06-13%20at%2017.22.35.png" width="250" /> 
</p>

## Snapshots - Astronomy Picture Detail view
<p float="left">
  <img src="https://github.com/rcasanovan/astropics/blob/main/Images/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-06-13%20at%2017.13.16.png" width="250" />
  <img src="https://github.com/rcasanovan/astropics/blob/main/Images/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20-%202024-06-13%20at%2017.14.34.png" width="250" />
</p>

## Requirements included in the demo
- As a user, when I open the app, I want to see the List page where it displays a list of Astronomy Picture of the Day for the last 7 days. Each item consists of its image, title, and captured date.
- As a user, when I tap on one item, I want to see a Detail page where it displays the image and the description.
- set the minimum deployment target to iOS 15.
- fetch data from a remote endpoint ([NASA](https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&start_date=YYYY-MM-DD&end_date=YYYY-MM-DD)).
- cover the code with tests (unit tests and snapshot tests).

## Additional tools / technologies
* [Swift-format](https://github.com/apple/swift-format): swift-format provides the formatting technology for SourceKit-LSP and the building blocks for doing code formatting transformations.
