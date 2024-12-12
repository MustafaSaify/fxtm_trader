import 'package:flutter/material.dart';
import 'package:fxtm_trader/src/routing/router.dart' as app_router;
import 'package:fxtm_trader/src/routing/routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  // To load the .env file contents into dotenv..
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FXTM Trader',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: forexList,
      onGenerateRoute: app_router.Router.generateRoute,
    );
  }
}
