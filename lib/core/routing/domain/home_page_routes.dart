import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hi_bob/features/games/matching_sentences_game/presentation/screens/matching_sentences_game.dart';
import 'package:hi_bob/features/games/matching_word_game/presentation/screens/matching_words_game.dart';
import 'package:hi_bob/features/home/presentation/screens/landing_tab.dart';
import 'package:hi_bob/features/profile/presentation/screens/profile_home_tab.dart';

final _shellNavigatorHomeMainTabKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeMainTabNavShell');
final _shellNavigatorHomeProfileTabKey =
    GlobalKey<NavigatorState>(debugLabel: 'homeProfileTabNavShell');

enum HomePageRoutes {
  main('homeLanding'),
  profile('profile'),
  matchingWordsGame('matchingWords', isTopLevel: false,),
  matchingSentencesGame('matchingSentencesGame', isTopLevel:false,);

  const HomePageRoutes(this.routeName, {this.isTopLevel = true,});

  final String routeName;
  final bool isTopLevel;

  String get path => isTopLevel ? '/$routeName' : routeName;

  static StatefulShellBranch get homeMainTab {
    return StatefulShellBranch(
      navigatorKey: _shellNavigatorHomeMainTabKey,
      routes: [
        GoRoute(
          path: main.path,
          name: main.routeName,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: LandingTabScreen(),
          ),
          routes: [
            GoRoute(
              path: matchingWordsGame.path,
              name: matchingWordsGame.routeName,
              builder: (context, state) {
                return MatchingWordsGameScreen(

                );
              },
            ),
            GoRoute(
              path: matchingSentencesGame.path,
              name: matchingSentencesGame.routeName,
              builder: (context, state) {
                return MatchingSentencesGameScreen(

                );
              },
            ),
          ],
        ),
      ],
    );
  }

  static StatefulShellBranch get homeProfileTab {
    return StatefulShellBranch(
      navigatorKey: _shellNavigatorHomeProfileTabKey,
      routes: [
        GoRoute(
          path: profile.path,
          name: profile.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            child: ProfileHomeTabScreen(),
          ),
          routes: [],
        ),
      ],
    );
  }
}

final List<StatefulShellBranch> homeTabs = [
  HomePageRoutes.homeMainTab,
  HomePageRoutes.homeProfileTab,
];
