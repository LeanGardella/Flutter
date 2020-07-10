class Movies {

  List<Movie> items = new List();
  
  Movies();

  Movies.fromJSON( List<dynamic> jsonList ) {
    if( jsonList == null ) {
      return;
    }
    for (var item in jsonList) {
      final m = new Movie.fromJson(item);
      items.add(m);
    }
  }


}

class Movie {
  String uniqueID;
  
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Movie(
      {this.popularity,
      this.voteCount,
      this.video,
      this.posterPath,
      this.id,
      this.adult,
      this.backdropPath,
      this.originalLanguage,
      this.originalTitle,
      this.genreIds,
      this.title,
      this.voteAverage,
      this.overview,
      this.releaseDate});

  Movie.fromJson(Map<String, dynamic> json) {
    popularity = json['popularity']/1.0;
    voteCount = json['vote_count'];
    video = json['video'];
    posterPath = json['poster_path'];
    id = json['id'];
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    genreIds = json['genre_ids'].cast<int>();
    title = json['title'];
    voteAverage = json['vote_average']/1.0;
    overview = json['overview'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity / 1;
    data['vote_count'] = this.voteCount;
    data['video'] = this.video;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds.cast<int>();
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage / 1;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    return data;
  }

  getPosterImg() {
    if( posterPath == null) 
      return 'https://png.pngtree.com/element_our/20190603/ourlarge/pngtree-movie-board-icon-image_1455346.jpg';
    else
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
  }

  getBackImg() {
    if( backdropPath == null) 
      return 'https://png.pngtree.com/element_our/20190603/ourlarge/pngtree-movie-board-icon-image_1455346.jpg';
    else
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
  }
}
