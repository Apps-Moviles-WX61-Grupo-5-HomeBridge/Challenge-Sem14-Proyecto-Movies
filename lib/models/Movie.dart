class Movie{
  int? id;
  String? overview;
  double? popularity;
  String? posterPath;
  String? title;
  String? realeaseDate;
  bool? isFavorite;

  Movie({
    this.id,
    this.overview,
    this.popularity,
    this.posterPath,
    this.title,
    this.realeaseDate,
    this.isFavorite,
  });

  Movie.fromJson(Map<String, dynamic> json){
    id = json['id'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    title = json['title'];
    realeaseDate = json['realeaseDate'];
    isFavorite = json['isFavorite'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['overview'] = this.overview;
    data['popularity'] = this.popularity;
    data['poster_path'] = this.posterPath;
    data['title'] = this.title;
    data['realeaseDate'] = this.realeaseDate;
    data['isFavorite'] = this.isFavorite;
    return data;
  }

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'title' : title,
    };
  }
}