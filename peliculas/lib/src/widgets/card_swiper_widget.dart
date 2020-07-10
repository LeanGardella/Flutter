import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Movie> elements;

  CardSwiper({ @required this.elements });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          final m = elements[index];
          m.uniqueID = '${m.id}-card';
          final item = new ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, 'detail', arguments: m);
              },
              child: FadeInImage(
                image: NetworkImage(m.getPosterImg()),
                placeholder: AssetImage('assets/dark-loading.gif'),
                fit: BoxFit.cover,
              ),
            )

          );
          return Hero(tag: m.uniqueID, child: item);
        },
        itemCount: elements.length,
        // pagination: new SwiperPagination(), // ···
        // control: new SwiperControl(), // <    >
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}