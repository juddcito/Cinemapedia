import 'package:cinemapedia/presentation/providers/storage/favorite_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_masonry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class FavoritesView extends ConsumerStatefulWidget {

  const FavoritesView({super.key});

  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {

  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {

    if (isLoading || isLastPage) return;
    isLoading = true;

    final movies = await ref.read(favoriteMoviesProvider.notifier).loadNextPage();
    isLoading = false;

    if (movies.isEmpty){
      isLastPage = true;
    }

  }

  @override
  Widget build(BuildContext context) {
    
    // convertir los valores a un List
    final favoriteMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoriteMovies.isEmpty){
      final colors = Theme.of(context).colorScheme;
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Icon(Icons.favorite_outline, size: 60,),
            Text('Ohhh no!!', style: TextStyle(fontSize: 30),),
            Text('No tienes películas favoritas', style: TextStyle(fontSize: 20, color: Colors.black45),)

          ],
        ),
      );
    }

    return Scaffold( 
      body: MovieMasonry(
        loadNextPage: loadNextPage,
        movies: favoriteMovies
      )
    );
  }
}