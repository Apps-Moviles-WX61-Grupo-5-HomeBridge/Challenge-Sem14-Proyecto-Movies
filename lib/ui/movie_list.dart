import 'package:app_movies/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:app_movies/utils/http_worker.dart';
import 'package:app_movies/models/Movie.dart';
import 'package:app_movies/ui/movie_details.dart';


class MovieList extends StatefulWidget {

  //  @Constructors
  const MovieList({super.key});

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  //  @Variables
  List mMovies = [];
  int mMoviesCount = 0;
  int mMoviePage = 1;
  bool mLoading = true;
  late HttpWorker mWorker;
  ScrollController? _scrollController;

  //  @Methods
  Future initialize() async{
    if(mWorker != null){
      List? fetchedMovies = await mWorker.getMovies('2');
      setState(() {
        mMovies = fetchedMovies!;
        mMoviesCount = mMovies.length;
        loadMovies();
        initScrollController();
      });
    }
  }

  @override
  void initState(){
    mWorker = HttpWorker();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" - Movies - "),
      ),
      body: ListView.builder(
          controller: _scrollController,
          itemCount: mMovies.length,
          itemBuilder: (BuildContext context, int index){
            return MovieRow(mMovies[index]);
          }),
    );
  }

  void loadMovies() {
    mWorker.getMovies(mMoviePage.toString()).then((value){
      mMovies + value;
      setState(() {
        mMoviesCount = mMovies.length;
        mMovies = mMovies;
        mMoviePage++;
      });

      if(mMovies.length % 25 > 0){
        mLoading = false;
      }
    });
  }

  void initScrollController() {
    _scrollController = ScrollController();
    _scrollController!.addListener((){
      if ((_scrollController!.position.pixels ==
          _scrollController!.position.maxScrollExtent) &&
          mLoading){
        loadMovies();
      }
    });
  }
}

class MovieRow extends StatefulWidget {

  //  @Variables
  final Movie mMovie;

  //  @Constructors
  MovieRow(this.mMovie);

  @override
  State<MovieRow> createState() => _MovieRowState(mMovie);
}

class _MovieRowState extends State<MovieRow> {

  //  @Variables
  final Movie mMovie;
  DatabaseHelper? mDbHelper;

  //  @Constructors
  _MovieRowState(this.mMovie);

  //  @Methods
  @override
  void initState() {
    mDbHelper = DatabaseHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: ListTile(
        leading: Hero(
          tag: 'poster_'+widget.mMovie.id.toString(),
          child: Image.network('https://image.tmdb.org/t/p/w500'+mMovie.posterPath.toString()),
        ),
        title: Text(widget.mMovie.title.toString()),
        subtitle: Text(widget.mMovie.overview.toString()),
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MovieDetail(widget.mMovie)
            ),
          );
        },
      ),
    );
  }
}

