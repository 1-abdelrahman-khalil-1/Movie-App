import 'package:dio/dio.dart';

class Api {
  String _api_key = "api_key=6d48795156109ff08dd855f091d0fce2";
  Dio dio = Dio();
  get_popular_data() async {
    Response request = await dio.get(
        "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1&$_api_key");
    Map<String, dynamic> dat = request.data;
    return dat["results"];
  }

  get_latest_data() async {
    Response request = await dio.get(
        "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=3&$_api_key");
    Map<String, dynamic> dat = request.data;
    return dat["results"];
  }

  get_top_rated() async {
    Response request = await dio.get(
        "https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1&$_api_key");
    Map<String, dynamic> dat = request.data;
    return dat["results"];
  }

  get_similar(int id) async {
    Response request = await dio.get(
        "https://api.themoviedb.org/3/movie/$id/similar?language=en-US&page=1&$_api_key");
    Map<String, dynamic> dat = request.data;
    return dat["results"];
  }

  get_movie_data(int id) async {
    Response request =
        await dio.get("https://api.themoviedb.org/3/movie/$id?$_api_key");
    Map<String, dynamic> dat = request.data;
    return dat;
  }

  get_upcoming_data() async {
    Response request = await dio.get(
        "https://api.themoviedb.org/3/movie/upcoming?language=en-US&page=1&$_api_key");
    Map<String, dynamic> dat = request.data;
    return dat["results"];
  }

  get_actors_data(int id) async {
    Response request = await dio
        .get("https://api.themoviedb.org/3/movie/$id/credits?$_api_key");
    Map<String, dynamic> dat = request.data;
    return dat["cast"];
  }

  get_searched_data(String movie) async {
    Response request = await dio
        .get("https://api.themoviedb.org/3/search/movie?query=$movie$_api_key");
    Map<String, dynamic> dat = request.data;
    return dat["results"];
  }
}


