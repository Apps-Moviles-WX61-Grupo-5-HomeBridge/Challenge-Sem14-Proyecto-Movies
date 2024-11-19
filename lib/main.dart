import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/Movie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Database Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Movies DB'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> _addMovie() async {
    Movie newMovie = Movie(
      id: 1,
      title: 'Inception',
      overview: 'A mind-bending thriller by Christopher Nolan.',
      popularity: 98.5,
      realeaseDate: '2010-07-16',
      isFavorite: true,
    );

    await _dbHelper.insertMovie(newMovie);
    _showMovies();
  }

  Future<void> _showMovies() async {
    List<Movie> movies = await _dbHelper.getAllMovies();
    for (var movie in movies) {
      print('Movie: ${movie.title}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _addMovie,
              child: const Text('Add Movie'),
            ),
            ElevatedButton(
              onPressed: _showMovies,
              child: const Text('Show Movies'),
            ),
          ],
        ),
      ),
    );
  }
}
