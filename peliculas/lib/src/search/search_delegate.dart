import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate{
  
  MoviesProvider moviesProv = new MoviesProvider();

  @override
  String get searchFieldLabel => 'Buscar...';

  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  String _selected = '';

  // final movies = [
  //   'Batman','Superman','Hulk','Ironman','Ironman 2','Batman: Dark Knight Rises','Aquaman','Linterna Verde','Capitán América','Spiderman','Spiderman 2','Avengers','Transformers','Transformers 2','Mujer maravilla',
  // ];

  // final suggested = [
  //   'Batman','Hulk','Capitán América'
  // ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Son las acciones de nuestro appbar (ej. limpiar el texto)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Es lo que aparece al inicio del appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Builder que crea los resultados que vamos a mostrar
    return Center(
      child: Container(
        height: 150.0,
        width: 150.0,
        color: Colors.indigo[800],
        child: Center(child: Text(_selected)),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Construye las sugerencias que aparecen cuando la persona escribe
    if(query.isEmpty) return Container();

    return FutureBuilder(
      future: moviesProv.findMovies(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if(snapshot.hasData)
          return ListView(
            children: snapshot.data.map((m) => 
              ListTile(
                onTap: () {
                  close(context, null);
                  m.uniqueID = '';
                  Navigator.pushNamed(context, 'detail', arguments: m);
                },
                title: Text(m.title),
                subtitle: Text(m.originalTitle),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  
                  child: FadeInImage(
                    placeholder: AssetImage('assets/dark-loading.gif'), 
                    image: NetworkImage(m.getPosterImg()),
                    fit: BoxFit.cover,
                    width: 50.0,
                  ),
              
                ),
              )
            ).toList(),
          );
        else
          return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  // @override
  // Widget buildSuggestions(BuildContext context) {
  //   // Construye las sugerencias que aparecen cuando la persona escribe

  //  final suggestionsList = query.isEmpty ? 
  //     suggested : 
  //     movies.where((movie) => movie.toLowerCase().contains(query.toLowerCase())).toList();

  //   return ListView.builder(
  //     itemCount: suggestionsList.length,
  //     itemBuilder: (context, index) {

  //       return ListTile(
  //         leading: Icon(Icons.movie_filter),
  //         title: Text(suggestionsList[index]),
  //         onTap: () {
  //           _selected = suggestionsList[index];
  //           showResults(context); // Llama al buildResults
  //         },
  //       );
  //     },
  //   );
  //}

}