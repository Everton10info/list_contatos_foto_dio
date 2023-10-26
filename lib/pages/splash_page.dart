import 'package:flutter/material.dart';
import 'package:list_contatos_foto_dio/controllers/contacts_controller.dart';
import 'package:list_contatos_foto_dio/pages/contacts_list_page.dart';
import 'package:list_contatos_foto_dio/pages/login_page.dart';

import '../repositories/auth_repository.dart';
import '../services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() async {
    token = await verifyUser();
    await Future.delayed(const Duration(seconds: 2));
    splasNextPage();

    super.didChangeDependencies();
  }

  bool token = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[600],
        body: const Stack(
          children: [
            Center(
                child: CircularProgressIndicator(
              strokeWidth: 300,
              strokeCap: StrokeCap.butt,
              backgroundColor: Colors.purpleAccent,
            )),
            Center(
              child: Text(
                'Contatos POC',
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }

  Future<bool> verifyUser() async {
    final rep = AuthRepositoryImpl(service: AuthService());
    return await rep.verifyToken();
  }

  void splasNextPage() async {
    if (token) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ListContactsPage(
              controller: ControllerContacts(),
            ),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ));
    }
  }
}
