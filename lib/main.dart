import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_radar/injector.dart';
import 'package:movie_radar/presentation/app/lang/l10n.dart';
import 'package:movie_radar/presentation/providers/configs_provider.dart';
import 'package:movie_radar/presentation/routes/router.dart';
import 'package:movie_radar/presentation/theming/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Injector
  await initializeDependencies();

  //Riverpod init
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDarkMode = ref.watch(isDarkModeProvider);
    final Locale selectedLocale = ref.watch(localeProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      title: 'Movie Radar',
      debugShowCheckedModeBanner: false,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: selectedLocale,
      theme: AppTheme(isDarkMode: isDarkMode).themeData(),
    );
  }
}
