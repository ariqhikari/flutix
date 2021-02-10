part of 'services.dart';

class MovieServices {
  static Future<List<Movie>> getNowPlayingMovies(int page,
      {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey&page=$page&region=ID';

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((movie) => Movie.fromJson(movie)).toList();
  }

  static Future<List<Movie>> getComingSoonMovies(int page,
      {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey&page=$page&region=ID';

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);
    List result = data['results'];

    return result.map((movie) => Movie.fromJson(movie)).toList();
  }
}
