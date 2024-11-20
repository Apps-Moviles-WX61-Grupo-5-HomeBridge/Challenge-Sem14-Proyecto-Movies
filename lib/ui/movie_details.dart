import 'package:app_movies/utils/database_helper.dart';
import 'package:flutter/material.dart';
import  '../models/Movie.dart';

final class MovieDetail extends StatefulWidget {
  //  @Variables
  final Movie mMovie;

  //  @Constructors
  const MovieDetail(this.mMovie, { super.key });

  @override
  MovieDetailState createState() => MovieDetailState(this.mMovie);
}

final class MovieDetailState extends State<MovieDetail> {
  //  @Variables
  final Movie mMovie;
  late DatabaseHelper mDbHelper;
  String mPath = "";

  //  @Constructors
  MovieDetailState(this.mMovie);

  //  @Methods
  @override void initState() {
    this.mDbHelper = DatabaseHelper();
    super.initState();
  }
  @override void setState(fn) {
    if (super.mounted) {
      super.setState(fn);
    }
  }

  @override Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(this.mMovie.title.toString()),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              child: Hero(
                  tag: 'poster_${this.mMovie.id}',
                  child: Image.network('https://image.tmdb.org/t/p/w500${this.mMovie.posterPath}',
                    height: height / 1.5,)
              ),
            )
          ],),
        ),
      ),
    );
  }
}