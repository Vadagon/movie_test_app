import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_test_app/api.dart';
import 'package:movie_test_app/model.dart';
import 'package:movie_test_app/repository.dart';
import 'package:movie_test_app/second.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Movie>> futureMovies;

  @override
  void initState() {
    super.initState();
    futureMovies = getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Demo proj')),
        body: FutureBuilder<List<Movie>>(
          future: futureMovies,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                height: 200.0,
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SecondScreen(data: snapshot.data![index]))),
                        child: Card(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                              CachedNetworkImage(
                                imageUrl: snapshot.data![index].poster.isEmpty
                                    ? "http://via.placeholder.com/200x150"
                                    : "https://www.themoviedb.org/t/p/w220_and_h330_face/" +
                                        snapshot.data![index].poster,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                        height: 140,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ))
                                        // ),
                                        ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              Container(
                                width: 120.0,
                                child: Text(snapshot.data![index].title),
                                alignment: Alignment.center,
                              )
                            ])));
                  },
                  scrollDirection: Axis.horizontal,
                ),
              );
            } else if (snapshot.hasError) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 30.0,
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text('${snapshot.error}'))
                  ]);
            }

            // By default, show a lading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }
}
