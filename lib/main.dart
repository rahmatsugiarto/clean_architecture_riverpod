import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'common/resources/strings.dart';
import 'common/utils/logger_provider.dart';
import 'presentation/pages/home_screen_desktop.dart';
import 'presentation/pages/home_screen_mobile.dart';
import 'presentation/pages/home_screen_tablet.dart';
import 'presentation/widgets/responsive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(
    observers: [LoggerProvider()],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      title: Strings.movies,
      debugShowCheckedModeBanner: false,
      home: const Responsive(
        mobile: HomeScreenMobile(),
        tablet: HomeScreenTablet(),
        desktop: HomeScreenDesktop(),
      ),
    );
  }
}
