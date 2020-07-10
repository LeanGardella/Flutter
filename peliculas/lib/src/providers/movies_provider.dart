import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/movie_model.dart';

class MoviesProvider {
  String _apiKey   = '633a2c266723e0dd501bf887355a269f';
  String _url      = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();

  final _popularsStream = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStream.sink.add;
  Stream<List<Movie>> get popularsStream => _popularsStream.stream;

  void disposeStreams() {
    _popularsStream.close();
  }


  Future<List<Movie>> getCurrentMovies() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJSON(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getPopularMovies() async {

    if(_loading) return [];

    _loading = true;
    _popularPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : _popularPage.toString(),
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJSON(decodedData['results']).items;

    _populars.addAll(movies);

    popularsSink(_populars);
    _loading = false;
    return movies;
  }

  Future<List<Actor>> getActors(String movieID) async {
    final url = Uri.https(_url, '3/movie/$movieID/credits', {
      'api_key' : _apiKey,
      'language': _language,
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    return Cast.fromJson(decodedData['cast']).actors;
  }


  Future<List<Movie>> findMovies(String query) async {
    final url = Uri.https(_url, '3/search/movie', {
      'api_key' : _apiKey,
      'language': _language,
      'query'   : query
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = Movies.fromJSON(decodedData['results']);

    return movies.items;
  }
}
