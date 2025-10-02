# Movie Browser - iOS Take Home Project

A native iOS app for browsing movies using The Movie Database (TMDB) API.

## 📋 Requirements

- Xcode 16.4+
- iOS 17.0+
- TMDB API Key

## 🚀 Setup Instructions

### 1. Clone the repository from your terminal
```bash
git clone https://github.com/stanleyoned/takehome-movie.git

cd takehome-movie
```

### 2. Configure your API key

Run the setup script on the project directory:
```bash
./scripts/setup.sh
```

Then open Config/Secrets.xcconfig and add your TMDB API key:
```
TMDB_API_KEY = your-actual-api-key-here
```

### 3. Open and Run
open takehome-movie.xcodeproj

Pick your own development team
Press ⌘ + R to build and run the app!

## Project Overview

**takehome-movie** is a modern iOS application built with SwiftUI that allows users to search for movies and view detailed information. The app follows MVVM architecture with Coordinator pattern for navigation, demonstrating clean architecture principles and modern iOS development practices.

### Architecture & Design

The application is built using **MVVM + Coordinator pattern** with dependency injection through an `AppStateContainer`. MVVM provides the simplest and most effective separation layer between view and business logic, making it ideal for apps of this scope compared to more complex architectures like VIPER or Composable Architecture which add unnecessary overhead for straightforward CRUD operations. The codebase is organized into feature modules with clear separation between UI, business logic, and data layers. A custom design system provides consistent typography (Baskerville font), spacing, and reusable components throughout the app.

### Core Features

Users can search for movies with real-time debounced input, browse search results in a clean list interface, and tap to view detailed movie information including poster images, ratings, release dates, and plot summaries. The app includes comprehensive error handling, loading states, and empty state management for optimal user experience.

### Technology Stack

Built with **SwiftUI** for the user interface and **ObservableObject** with `@Published` properties for reactive communication between Views and ViewModels. The app uses **URLSession** for networking and integrates with **The Movie Database (TMDB) API**, targeting iOS 15.0+. A robust networking layer features generic request handling, automatic JSON decoding with snake_case conversion, and comprehensive error management.

### Testing & Quality

The project includes extensive unit test coverage with separate test files for ViewModels, Models, and Network layer. Mock implementations provide clean test isolation, with proper async/await testing patterns and comprehensive error scenario coverage. The codebase demonstrates production-ready practices including secure API key management and localized strings.

## 🎥 Demo

### Project Walkthrough

[![Project Walkthrough](https://img.youtube.com/vi/b2Ysl8GZstY/0.jpg)](https://youtu.be/b2Ysl8GZstY)

### Coding Session Recording: using AI

[![Coding Session Recording: using AI](https://img.youtube.com/vi/-H3qnEmyYik/0.jpg)](https://youtu.be/-H3qnEmyYik)
