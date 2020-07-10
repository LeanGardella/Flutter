import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Movie> movies;
  Function onMaxExtent;

  final _pageController = new PageController(initialPage: 1, viewportFraction: 0.3);

  MovieHorizontal({@required this.movies, @required this.onMaxExtent });
  
  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() { 
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent -200 )
        onMaxExtent();
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        // children: _populares(context),
        itemCount: movies.length,
        itemBuilder: (context, i) => _item(context, movies[i]),
      ),
    );
  }

  Widget _item ( BuildContext context, Movie m) {
    m.uniqueID = '${m.id}-horizontal';
    final item =  Container(
        
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
                tag: m.uniqueID,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(m.getPosterImg()),
                  placeholder: AssetImage('assets/dark-loading.gif'),
                  fit: BoxFit.cover,
                  height: 150.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              m.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );

      return GestureDetector(
        child: item,
        onTap: () {
          Navigator.pushNamed(context, 'detail', arguments: m);
        },
      );
  }

  List<Widget> _populares(BuildContext context) {
    return movies.map((m)  {
      return Container(
        
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
          
              
              ClipRRect(
                borderRadius: BorderRadius.circular(0.0),
                child: FadeInImage(
                  image: NetworkImage(m.getPosterImg()),
                  placeholder: AssetImage('assets/dark-loading.gif'),
                  fit: BoxFit.cover,
                  height: 150.0,
                ),
              ),
         
            SizedBox(height: 5.0),
            Text(
              m.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}