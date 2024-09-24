import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/data.dart';

abstract class Movies_state {}

class Init extends Movies_state {}

class Loading extends Movies_state {}

class Success extends Movies_state {
  List popular_posters, latest_posters, toprated_posters, upcoming_posters;
  Success(this.latest_posters, this.popular_posters, this.toprated_posters,
      this.upcoming_posters);
}

class Error extends Movies_state {
  final Error_Message;

  Error(this.Error_Message);
}

class Movies_Cubit extends Cubit<Movies_state> {
  Movies_Cubit() : super(Init());
  Api service = Api();
  List popular_movies = [],
      popular_posters = [],
      latest_movies = [],
      latest_posters = [],
      toprated = [],
      toprated_posters = [],
      upcoming_movies = [],
      upcoming_posters = [];

  get_popular() async {
    emit(Loading());
    try {
      popular_movies = await service.get_popular_data();
      for (int i = 0; i < popular_movies.length; i++) {
        popular_posters.add([
          "https://image.tmdb.org/t/p/original${popular_movies[i]["poster_path"]}",
          popular_movies[i]["id"]
        ]);
      }
      emit(Success(
          latest_posters, popular_posters, toprated_posters, upcoming_posters));
    } catch (e) {
      emit(Error(e));
    }
  }

  get_latest() async {
    emit(Loading());
    try {
      latest_movies = await service.get_latest_data();
      for (int i = 0; i < latest_movies.length; i++) {
        latest_posters.add([
          "https://image.tmdb.org/t/p/original${latest_movies[i]["poster_path"]}",
          latest_movies[i]["id"]
        ]);
      }
      emit(Success(
          latest_posters, popular_posters, toprated_posters, upcoming_posters));
    } catch (e) {
      emit(Error(e));
    }
  }

  get_top_rated() async {
    emit(Loading());
    try {
      toprated = await service.get_popular_data();
      for (int i = 0; i < toprated.length; i++) {
        toprated_posters.add([
          "https://image.tmdb.org/t/p/original${toprated[i]["poster_path"]}",
          toprated[i]["id"]
        ]);
      }
      emit(Success(
          latest_posters, popular_posters, toprated_posters, upcoming_posters));
    } catch (e) {
      emit(Error(e));
    }
  }

  get_upcoming() async {
    emit(Loading());
    try {
      upcoming_movies = await service.get_upcoming_data();
      for (int i = 0; i < upcoming_movies.length; i++) {
        upcoming_posters.add([
          "https://image.tmdb.org/t/p/original${upcoming_movies[i]["poster_path"]}",
          upcoming_movies[i]["id"]
        ]);
      }
      emit(Success(
          latest_posters, popular_posters, toprated_posters, upcoming_posters));
    } catch (e) {
      emit(Error(e));
    }
  }
}
