import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:samples/namaz_vakitleri/home_screen.dart';
import 'package:samples/news_app/viewModel/articleListViewModel.dart';
import 'package:samples/news_turkish/screen/detailPage.dart';
import 'package:samples/news_turkish/screen/home.dart';
import 'package:samples/news_turkish/screen/login_screen.dart';
import 'package:samples/news_turkish/view_model/result_list_view_model.dart';
import 'package:samples/to_do_list_app.dart/screen/add_tast.dart';
import 'package:samples/to_do_list_app.dart/screen/header.dart';
import 'package:samples/weather_app/bos.dart';
// Import the generated file
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ResultListViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            color: Colors.transparent,
            elevation: 0,
            centerTitle: true),
        textTheme: GoogleFonts.robotoSlabTextTheme(
          Theme.of(context).textTheme?.copyWith(
                titleLarge: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 26,
                    color: Colors.white),
                bodyMedium: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color.fromARGB(255, 238, 227, 227),
                    fontWeight: FontWeight.w500),
                bodyLarge: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white),
              ),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
