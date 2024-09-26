import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/Data/data.dart';

abstract class Movies_state {}

class Init extends Movies_state {}

class Loading extends Movies_state {}

class Success extends Movies_state {
  List popular_posters,
      latest_posters,
      upcoming_posters,
      same_posters,
      language,
      search_results,
      actors,
      sim;
  List<Widget> toprated_posters;
  int duration;
  String path, name, overview, release_date;
  double rate;
  String genre;
  Map<String, dynamic> Details;
  Map<int, bool> selected;
  Success(
      this.latest_posters,
      this.popular_posters,
      this.toprated_posters,
      this.upcoming_posters,
      this.Details,
      this.duration,
      this.genre,
      this.language,
      this.path,
      this.name,
      this.overview,
      this.release_date,
      this.rate,
      this.same_posters,
      this.selected,
      this.search_results,
      this.actors,
      this.sim);
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
      upcoming_movies = [],
      upcoming_posters = [],
      search_results = [],
      actors = [],
      Similar_posters = [],
      sim = [];
  List<Widget> toprated_posters = [];
  int i = 0, duration = 0;
  String path = "", name = "", overview = "", release_date = "";
  double rate = 0;
  List same_posters = [], language = [];
  String genre = "";
  Map<String, dynamic> Details = {};
  Map<int, bool> selected = {};
  get_popular() async {
    emit(Loading());
    popular_posters = [];
    try {
      popular_movies = await service.get_popular_data();
      for (int i = 0; i < popular_movies.length; i++) {
        popular_posters.add([
          "https://image.tmdb.org/t/p/original${popular_movies[i]["poster_path"]}",
          popular_movies[i]["id"]
        ]);
      }
      emit(Success(
          latest_posters,
          popular_posters,
          toprated_posters,
          upcoming_posters,
          Details,
          duration,
          genre,
          language,
          path,
          name,
          overview,
          release_date,
          rate,
          same_posters,
          selected,
          search_results,
          actors,
          sim));
    } catch (e) {
      emit(Error(e));
    }
  }

  get_latest() async {
    emit(Loading());
    latest_posters = [];

    try {
      latest_movies = await service.get_latest_data();
      for (int i = 0; i < latest_movies.length; i++) {
        latest_posters.add([
          "https://image.tmdb.org/t/p/original${latest_movies[i]["poster_path"]}",
          latest_movies[i]["id"]
        ]);
      }
      emit(Success(
          latest_posters,
          popular_posters,
          toprated_posters,
          upcoming_posters,
          Details,
          duration,
          genre,
          language,
          path,
          name,
          overview,
          release_date,
          rate,
          same_posters,
          selected,
          search_results,
          actors,
          sim));
    } catch (e) {
      emit(Error(e));
    }
  }

  get_top_rated() async {
    emit(Loading());
    toprated_posters = [];

    try {
      toprated = await service.get_top_rated();
      for (int i = 0; i < 10; i++) {
        toprated_posters.add(Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://image.tmdb.org/t/p/original${toprated[i]["poster_path"]}"),
                    fit: BoxFit.fill))));
      }
      emit(Success(
          latest_posters,
          popular_posters,
          toprated_posters,
          upcoming_posters,
          Details,
          duration,
          genre,
          language,
          path,
          name,
          overview,
          release_date,
          rate,
          same_posters,
          selected,
          search_results,
          actors,
          sim));
    } catch (e) {
      emit(Error(e));
    }
  }

  get_upcoming() async {
    emit(Loading());
    upcoming_posters = [];

    try {
      upcoming_movies = await service.get_upcoming_data();
      for (int i = 0; i < upcoming_movies.length; i++) {
        upcoming_posters.add([
          "https://image.tmdb.org/t/p/original${upcoming_movies[i]["poster_path"]}",
          upcoming_movies[i]["id"]
        ]);
      }
      emit(Success(
          latest_posters,
          popular_posters,
          toprated_posters,
          upcoming_posters,
          Details,
          duration,
          genre,
          language,
          path,
          name,
          overview,
          release_date,
          rate,
          same_posters,
          selected,
          search_results,
          actors,
          sim));
    } catch (e) {
      emit(Error(e));
    }
  }

  get_movie(int id) async {
    emit(Loading());
    release_date = "";
    try {
      Details = await service.get_movie_data(id);
      path = "https://image.tmdb.org/t/p/original${Details["poster_path"]}";
      name = Details["title"];
      overview = Details["overview"];
      duration = Details["runtime"];
      language = Details["spoken_languages"];
      rate = Details["vote_average"];
      genre = Details["genres"].map((x) => x["name"]).join(" , ");
      for (int i = 0; i < 4; i++) {
        release_date += Details["release_date"][i];
      }

      emit(Success(
          latest_posters,
          popular_posters,
          toprated_posters,
          upcoming_posters,
          Details,
          duration,
          genre,
          language,
          path,
          name,
          overview,
          release_date,
          rate,
          same_posters,
          selected,
          search_results,
          actors,
          sim));
    } catch (e) {
      emit(Error(e));
    }
  }

  get_results(String movie_id) async {
    emit(Loading());
    try {
      search_results = [];
      List results = await service.get_searched_data(movie_id);

      for (int i = 0; i < results.length; i++) {
        path =
            "https://image.tmdb.org/t/p/original${results[i]["poster_path"]}";
        name = results[i]["title"];
        rate = results[i]["vote_average"];
        int id = results[i]["id"];
        if (results[i]["poster_path"] != null) {
          search_results.add([name, rate, path, id]);
        }
      }
      emit(Success(
          latest_posters,
          popular_posters,
          toprated_posters,
          upcoming_posters,
          Details,
          duration,
          genre,
          language,
          path,
          name,
          overview,
          release_date,
          rate,
          same_posters,
          selected,
          search_results,
          actors,
          sim));
    } catch (e) {
      emit(Error(e));
    }
  }

  get_similar(int id) async {
    emit(Loading());
    try {
      Similar_posters = [];
      sim = await service.get_similar(id);
      for (int i = 0; i < sim.length; i++) {
        Similar_posters.add([
          "https://image.tmdb.org/t/p/original${sim[i]["poster_path"]}",
          sim[i]["id"]
        ]);
      }
      emit(Success(
          latest_posters,
          popular_posters,
          toprated_posters,
          upcoming_posters,
          Details,
          duration,
          genre,
          language,
          path,
          name,
          overview,
          release_date,
          rate,
          same_posters,
          selected,
          search_results,
          actors,
          sim));
    } catch (e) {
      emit(Error(e));
    }
  }

  get_actors(int id) async {
    emit(Loading());
    try {
      actors = [];
      List p = await service.get_actors_data(id);
      for (int i = 0; i < p.length; i++) {
        if( p[i]["known_for_department"] =="Acting") {
          actors.add([
          p[i]["name"],
          "https://image.tmdb.org/t/p/original${p[i]["profile_path"]}",
          p[i]["character"]
        ]);
        }
      }
      emit(Success(
          latest_posters,
          popular_posters,
          toprated_posters,
          upcoming_posters,
          Details,
          duration,
          genre,
          language,
          path,
          name,
          overview,
          release_date,
          rate,
          same_posters,
          selected,
          search_results,
          actors,
          sim));
    } catch (e) {
      emit(Error(e));
    }
  }
}
