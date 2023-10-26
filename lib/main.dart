import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:list_contatos_foto_dio/pages/splash_page.dart';
import 'package:list_contatos_foto_dio/shared/config/environments.dart';
import 'services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await DotEnv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('uuuurlll ${AppEnvironments.url.toString()}');
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'List Contatos',
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.purple,
        ),
        home: const SplashPage());
  }
}
