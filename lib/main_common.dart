import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:hi_bob/core/routing/domain/go_routing_config.dart';
import 'package:hi_bob/core/translations/domain/models/supported_languages.dart';
import 'package:hi_bob/core/ui/theme/app_theme.dart';
import 'package:hi_bob/core/utils/extensions/dartz_ext.dart';
import 'package:hi_bob/features/user_preferences/domain/models/user_preferences.dart';
import 'package:hi_bob/features/user_preferences/domain/usecases/user_preferences_usecases.dart';
import 'package:hi_bob/flavor_config.dart';
import 'package:hi_bob/main_init.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainInit.init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  StreamSubscription<UserPreferences?>? _preferencesStream;
  UserPreferences _preferences = UserPreferences();

  @override
  void initState() {
    super.initState();
    _setupPreferencesStream();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: StreamBuilder<UserPreferences?>(
        stream: GetIt.I.get<ListenToUserPreferencesChangesUseCase>().call(),
        builder: (context, snapshot) {
          return MaterialApp.router(
            routerConfig: goRouter,
            title: FlavorConfig.instance.appTitle,
            debugShowCheckedModeBanner: FlavorConfig.instance.isDevelopment,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: SupportedLanguages.getLocale(
              languageCode: _preferences.language.languageCode,
            ),
            theme: appLightTheme,
            darkTheme: darkTheme,
            themeMode:
                _preferences.prefersDarkMode ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }

  Future<void> _setupPreferencesStream() async {
    final preferencesUseCase = GetIt.I.get<UserPreferencesUseCases>();

    // initialize user preferences
    final currentPreferences = await preferencesUseCase.getPreferencesUseCase();
    if (currentPreferences.isSuccess) {
      setState(() {
        _preferences = currentPreferences.asSuccess();
      });
    }
    if (currentPreferences.isError) {
      setState(() {
        _preferences = _preferences;
      });
    }

    // set listener to preferences
    _preferencesStream = preferencesUseCase
        .listenToPreferencesChangesUseCase()
        .listen((UserPreferences? preferences) {
      final newPreferences = preferences ?? _preferences;
      setState(() {
        _preferences = newPreferences;
      });
    });
  }

  @override
  void dispose() {
    _preferencesStream?.cancel();
    MainInit.dispose();
    super.dispose();
  }
}
