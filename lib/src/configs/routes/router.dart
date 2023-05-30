import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/generation/presentation/pages/pokemon_generation_list_page.dart';
import '../../features/generation/presentation/pages/generation_page.dart';
import '../../features/pokemon_detail/presentation/pages/pokemon_detail_page.dart';
import '../../features/search_pokemon/presentation/pages/search_pokemon_page.dart';


CustomTransitionPage buildPageWithTransition<T>({
  required BuildContext context, 
  required GoRouterState state, 
  required Widget child,
}) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.easeInOut;
  final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) => 
      SlideTransition(position: animation.drive(tween), child: child)
  );
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const GenerationPage(),
      routes: [
        GoRoute(
          path: 'generation/:id',
          pageBuilder: (context, state) => buildPageWithTransition(
            child: PokemonGenerationListPage(id: int.parse(state.pathParameters['id']!)),
            context: context,
            state: state
          ) 
        )
      ]
    ),
    GoRoute(
      path: '/pokemon/:id',
      pageBuilder: (context, state) => buildPageWithTransition(
        child: PokemonDetailPage(id: int.parse(state.pathParameters['id']!)),
        context: context,
        state: state
      )
    ),
    GoRoute(
      path: '/search',
      pageBuilder: (context, state) => buildPageWithTransition(
        child: const SearchPokemonPage(),
        context: context,
        state: state
      )
    ),
  ]
);