import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movies_module/domain/entities/movie.dart';
import 'package:shared_module/core/utils/helpers/navigate_helper.dart';
import 'package:shared_module/presentation/widgets/custom_asset_image.dart';

class MoviePosterLink extends StatelessWidget {
  final Movie movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final random = Random();

    return FadeInUp(
      from: random.nextInt(100) + 80,
      delay: Duration(milliseconds: random.nextInt(450) + 0),
      child: GestureDetector(
        onTap: () => navigateToMovieScreen(context, movie.id),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            height: 180,
            fit: BoxFit.cover,
            placeholder: customAssetImage(),
            image: NetworkImage(movie.posterPath),
            imageErrorBuilder: (context, error, stackTrace) => Container(),
          ),
        ),
      ),
    );
  }
}
