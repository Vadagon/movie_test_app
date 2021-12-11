import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_test_app/model.dart';

class SecondScreen extends StatelessWidget {
  // const SecondScreen({this.data}) : super();
  final Movie data;
  const SecondScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Demo proj')),
        body: Column(children: [
          Container(height: 40),
          CachedNetworkImage(
            imageUrl: data.poster.isEmpty
                ? "http://via.placeholder.com/200x150"
                : "https://www.themoviedb.org/t/p/w220_and_h330_face/" +
                    data.poster,
            imageBuilder: (context, imageProvider) => Container(
                height: 140,
                width: 120,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ))
                // ),
                ),
            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          Container(height: 30),
          Text(data.title),
          Container(height: 30),
          SizedBox(width: double.infinity, child: Text(data.overview))
        ]));
  }
}
