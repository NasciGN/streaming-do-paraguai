import 'package:http/http.dart' as http;
import '../models/filmes.dart';
import 'dart:convert';

class TmdbService {
  String urlAPI = '1eea2e5c113db4b971e3bbf50ec104c8&language=pt-BR&page=1';
  String baseURL = 'https://api.themoviedb.org/3';
  String imgURL = 'https://image.tmdb.org/t/p/w500';

  // BUSCA OS FILMES POPULARES
  Future<List<Filmes>> fetchPopularMovies() async {
    final http.Response response =
        await http.get(Uri.parse('$baseURL/movie/popular?api_key=$urlAPI'));

    List<Filmes> filmes =
        []; // Cria uma lista de Objetos para receber os filmes populares.
    var jsonResponse = json.decode(response.body);
    for (var filmeJason in jsonResponse['results']) {
      // Percorre o JSON de results para armazenar o ID de cada filme que está lá
      Filmes filme = await fetchMovieDetails(filmeJason[
          'id']); // Chama o metodo para buscar os detalhes de cada filme com base no ID obtido na linha anterior, Esse método retorna um objeto
      filmes.add(filme); // Adiciona o objeto dentro da lista de filmes
      print('Filme adicionado: $filmes.toString()');
    }
    return filmes;
  }

  // BUSCA OS FILMES MAIS BEM AVALIADOS
  Future<List<Filmes>> fetchTopRaterMovies() async {
    final http.Response response =
        await http.get(Uri.parse('$baseURL/movie/top_rated?api_key=$urlAPI'));

    List<Filmes> filmes =
        []; // Cria uma lista de Objetos para receber os filmes populares.
    var jsonResponse = json.decode(response.body);
    for (var filmeJason in jsonResponse['results']) {
      // Percorre o JSON de results para armazenar o ID de cada filme que está lá
      Filmes filme = await fetchMovieDetails(filmeJason[
          'id']); // Chama o metodo para buscar os detalhes de cada filme com base no ID obtido na linha anterior, Esse método retorna um objeto
      filmes.add(filme); // Adiciona o objeto dentro da lista de filmes
      print('Filme adicionado: $filmes.toString()');
    }
    return filmes;
  }

  // BUSCA OS FILMES QUE SERAO EXIBIDOS EM BREVE
  Future<List<Filmes>> fetchUpComingMovies() async {
    final http.Response response =
        await http.get(Uri.parse('$baseURL/movie/upcoming?api_key=$urlAPI'));

    List<Filmes> filmes =
        []; // Cria uma lista de Objetos para receber os filmes populares.
    var jsonResponse = json.decode(response.body);
    for (var filmeJason in jsonResponse['results']) {
      // Percorre o JSON de results para armazenar o ID de cada filme que está lá
      Filmes filme = await fetchMovieDetails(filmeJason[
          'id']); // Chama o metodo para buscar os detalhes de cada filme com base no ID obtido na linha anterior, Esse método retorna um objeto
      filmes.add(filme); // Adiciona o objeto dentro da lista de filmes
      print('Filme adicionado: $filmes.toString()');
    }
    return filmes;
  }

  // BUSCA OS FILMES EM CARTAZ
  Future<List<Filmes>> fetchPlayNowMovies() async {
    final http.Response response =
        await http.get(Uri.parse('$baseURL/movie/now_playing?api_key=$urlAPI'));

    List<Filmes> filmes =
        []; // Cria uma lista de Objetos para receber os filmes populares.
    var jsonResponse = json.decode(response.body);
    for (var filmeJason in jsonResponse['results']) {
      // Percorre o JSON de results para armazenar o ID de cada filme que está lá
      Filmes filme = await fetchMovieDetails(filmeJason[
          'id']); // Chama o metodo para buscar os detalhes de cada filme com base no ID obtido na linha anterior, Esse método retorna um objeto
      filmes.add(filme); // Adiciona o objeto dentro da lista de filmes
      print('Filme adicionado: $filmes.toString()');
    }
    return filmes;
  }

  // BUSCA OS DETALHES DE CADA FILME
  Future<Filmes> fetchMovieDetails(int idFilme) async {
    final response = await http.get(Uri.parse(
        '$baseURL/movie/$idFilme?api_key=$urlAPI&append_to_response=videos&language=pt-BR')); // Busca o filme com base no ID fornecido

    if (response.statusCode == 200) {
      var filmeJson = jsonDecode(response.body);

      List<String> generos = [];
      for (var genreJson in filmeJson['genres']) {
        // Percorre o dicionario da lista de generos e os adiciona numa lista
        generos.add(genreJson['name']);
      }

      return Filmes(
        tituloOriginal: filmeJson['original_title'],
        titulo: filmeJson['title'],
        sinopse: filmeJson['overview'],
        nota: filmeJson['vote_average'],
        genero: generos,
        urlPoster: '$imgURL${filmeJson['poster_path']}',
      );
    } else {
      throw Exception('Falha ao carregar detalhes do filme');
    }
  }
}
