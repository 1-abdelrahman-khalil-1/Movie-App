
# Movie App

Welcome to the Movie App! This application provides users with an immersive experience to explore and discover movies. It offers detailed information about movies, including ratings, summaries, and more.

## Features

- **Browse Movies**: Explore a wide range of movies with detailed information.
- **Search Functionality**: Easily find movies by title or genre.
- **Favorites**: Mark movies as favorites for quick access.
- **Detailed Information**: View comprehensive details about each movie, including cast, plot summary, and ratings.

## Technologies Used

- **Flutter**: A UI toolkit for building natively compiled applications for mobile from a single codebase. [Learn more](https://flutter.dev/)
- **Dart**: The programming language used in Flutter development. [Learn more](https://dart.dev/)
- **Cubit (from the BLoC package)**: A lightweight state management solution that is part of the BLoC (Business Logic Component) library. It allows for efficient state management by emitting new states via methods without the need for events. [Learn more](https://bloclibrary.dev/#/cubit)

## State Management with Cubit

In this application, we utilize Cubit for state management. Cubit is a subset of the BLoC pattern that simplifies state management by eliminating the need for events. Instead, it uses methods to emit new states, reducing boilerplate and enhancing readability.

**Example Implementation:**

```dart
import 'package:bloc/bloc.dart';

class MovieCubit extends Cubit<MovieState> {
  MovieCubit() : super(MovieInitial());

  void fetchMovies() {
    try {
      emit(MovieLoading());
      // Fetch movies from API or database
      final movies = // fetched movies;
      emit(MovieLoaded(movies));
    } catch (e) {
      emit(MovieError("Failed to fetch movies"));
    }
  }
}


In the UI, we can listen to the `MovieCubit` and rebuild widgets based on the current state:

```dart
BlocBuilder<MovieCubit, MovieState>(
  builder: (context, state) {
    if (state is MovieLoading) {
      return CircularProgressIndicator();
    } else if (state is MovieLoaded) {
      return MovieList(movies: state.movies);
    } else if (state is MovieError) {
      return Text(state.message);
    }
    return Container();
  },
);
```

This approach ensures a clear separation of concerns, with the `MovieCubit` handling the business logic and the UI reacting to state changes accordingly.

## Getting Started

To run this application locally:

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/1-abdelrahman-khalil-1/Movie-App.git
   cd Movie-App
   ```

2. **Install Dependencies**:
   Ensure you have Flutter installed. Then, run:
   ```bash
   flutter pub get
   ```

3. **Run the Application**:
   ```bash
   flutter run
   ```

## Contributing

We welcome contributions! If you'd like to contribute, please fork the repository and submit a pull request. Ensure that your code adheres to the project's coding standards and includes appropriate tests.
