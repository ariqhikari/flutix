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

  static Future<Movie> getDetailsMovie(Movie movie,
      {int movieID, http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/${movieID ?? movie.id}?api_key=$apiKey';

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return null;
    }

    var data = json.decode(response.body);
    List genres = (data as Map<String, dynamic>)['genres'];

    List languages = (data as Map<String, dynamic>)['spoken_languages'];
    String language = (languages[0] as Map<String, dynamic>)['english_name'];

    return (movieID != null)
        ? MovieDetail(
            Movie.fromJson(data),
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList(),
          )
        : MovieDetail(
            movie,
            language: language,
            genres: genres
                .map((e) => (e as Map<String, dynamic>)['name'].toString())
                .toList(),
          );
  }

  static Future<List<Credit>> getCreditsMovie(int movieID,
      {http.Client client}) async {
    String url =
        'https://api.themoviedb.org/3/movie/$movieID/credits?api_key=$apiKey';

    client ??= http.Client();

    var response = await client.get(url);

    if (response.statusCode != 200) {
      return [];
    }

    var data = json.decode(response.body);

    return ((data as Map<String, dynamic>)['cast'] as List)
        .map((e) => Credit(
              name: (e as Map<String, dynamic>)['name'],
              profilePath: (e as Map<String, dynamic>)['profile_path'],
            ))
        .take(8)
        .toList();
  }
}
