import 'package:flutter/material.dart';

import 'package:peliculas/src/models/actor_model.dart';
import 'package:peliculas/src/models/movie_model.dart';

import 'package:peliculas/src/providers/movies_provider.dart';

class MovieDetails extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

  final Movie _movie = ModalRoute.of(context).settings.arguments;
  
    return Scaffold(
      body: Container(

        child: CustomScrollView(
          
          slivers: <Widget>[
            _crearAppBar(_movie),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 10.0,),
                   _posterTitulo(_movie, context),
                   _descripcion(_movie),_descripcion(_movie),_descripcion(_movie),_descripcion(_movie),
                   _movieCasting(_movie),
                ]
              ),
            ),
            
          ],
        ),
      ),
    );
  }

  Widget _crearAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigo[800],
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackImg()),
          placeholder: AssetImage('assets/infinity-loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _posterTitulo(Movie movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: 
        Row(
          children: <Widget>[
            Hero(
              tag: movie.uniqueID,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(movie.getPosterImg()),
                  height: 150.0,
                ),
              ),
            ),
            SizedBox(width: 10.0,),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(movie.title, style: Theme.of(context).textTheme.headline6,),
                  Text(movie.originalTitle, style: Theme.of(context).textTheme.subtitle1,),
                  Row(
                    children: <Widget>
                    [
                      Icon(Icons.star_border),
                      Text(movie.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
     
    );
  }

  _descripcion(Movie movie) {

    return Container(
      padding: EdgeInsets.all(20.0),
      child: Text(movie.overview, textAlign: TextAlign.justify,),
    );
  }

  Widget _movieCasting(Movie movie) {
    final movieProv = new MoviesProvider();
    return FutureBuilder(
      future: movieProv.getActors(movie.id.toString()),
      builder: ( context, AsyncSnapshot snapshot) {
        if(snapshot.hasData)
          return _crearActorsView(snapshot.data);
        else
          return Center(child: CircularProgressIndicator(),);
      },
    );
  }

  Widget _crearActorsView(List<Actor> data) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        itemCount: data.length,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        pageSnapping: false,
        itemBuilder: (context, i) { return _actorTarjeta(data[i]); },
      ),
    );
  }

  Widget _actorTarjeta(Actor actor) {
    return Container(
      child: Column(
        children: <Widget>
        [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage( actor.getProfileImg()),
              placeholder: AssetImage('assets/dark-loading.gif'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis,),
        ],
      ),
    
    );
  }
}