import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:movies/providers/movies.dart';

class CastItem extends StatelessWidget {
  final String name;
  final String imdb_code;
  final String image_url;
  final String character_name;
  CastItem({
    this.name,
    this.imdb_code,
    this.image_url,
    this.character_name,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipOval(
        child: image_url == null
            ? Image.asset('assets/images/person_placeholder.png')
            : FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: image_url,
              ),
      ),
      title: Text(name),
      subtitle: Text(character_name),
    );
  }
}
