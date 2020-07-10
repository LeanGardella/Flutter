import 'package:flutter/material.dart';
import 'package:peliculas/src/providers/movies_provider.dart';
import 'package:peliculas/src/search/search_delegate.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {

  final _moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    _moviesProvider.getPopularMovies();

    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('MetFlix movies'),
          centerTitle: false,
          backgroundColor: Colors.indigo[800],
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                  
                );
              },
            )
          ],
        ),
        body: Container(
         
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _swiperCards(),
              _footer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: _moviesProvider.getCurrentMovies(),
      
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) 
        { 
          return CardSwiper(
            elements: snapshot.data,
          );
        }
        else
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
      },
    );
  }

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subtitle1)
          ),  
          SizedBox(height: 10.0,),
          StreamBuilder(
            stream: _moviesProvider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData) {
                return MovieHorizontal(movies: snapshot.data, onMaxExtent: _moviesProvider.getPopularMovies);
              }else {
                return Center(child: CircularProgressIndicator());
              }
             
            },
          ),
        ],
      ),
    );
  }
}