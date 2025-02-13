import 'package:flutter/material.dart';
import 'package:governement_service_app/screens/pages/home.dart';
import 'package:governement_service_app/screens/pages/detail_page.dart';
import 'package:governement_service_app/utils/helpers/bookmark_provider.dart';
import 'package:governement_service_app/utils/helpers/internet_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Internetprovider()),
        ChangeNotifierProvider(create: (_) => BookmarkProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        ),
        initialRoute: 'landing_page',
        routes: {
          'landing_page': (context) => LandingPage(),
          'detail_page': (context) => DetailPage(),
        },
      ),
    );
  }
}
