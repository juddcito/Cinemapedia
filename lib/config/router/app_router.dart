import 'package:go_router/go_router.dart';

import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
        path: '/home/:page',
        name: HomeScreen.name,
        builder: (context, state) {
          String pageIndex = state.params['page'] ?? '0';
          if (int.parse(pageIndex) > 2 || int.parse(pageIndex) < 0) {
            pageIndex = '0';
          }
          return HomeScreen(pageIndex: int.parse(pageIndex));
        },
        routes: [
          GoRoute(
            path: 'movie/:id',
            name: MovieScreen.name,
            builder: (context, state) {
              final movieId = state.params['id'] ?? 'no-id';
              return MovieScreen(movieId: movieId);
            },
          ),
        ]
    ),
    GoRoute(
      path: '/',
      redirect: ( _ , __ ) => '/home/0',
    )
]);





    // Rutas padre/hijo
    // GoRoute(
    //   path: '/',
    //   name: HomeScreen.name,
    //   builder: (context, state) => const HomeScreen( childView: HomeView(), ),
    //   routes: [
    //      GoRoute(
    //       path: 'movie/:id',
    //       name: MovieScreen.name,
    //       builder: (context, state) {
    //         final movieId = state.params['id'] ?? 'no-id';

    //         return MovieScreen( movieId: movieId );
    //       },
    //     ),
    //   ]
    // ),
