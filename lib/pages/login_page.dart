import 'package:flutter/material.dart';
import 'package:list_contatos_foto_dio/controllers/contacts_controller.dart';
import 'package:list_contatos_foto_dio/controllers/login_controller.dart';
import 'package:list_contatos_foto_dio/core/enums/login_enum.dart';
import 'package:list_contatos_foto_dio/pages/contacts_list_page.dart';
import 'package:list_contatos_foto_dio/repositories/login_repository.dart';
import 'package:list_contatos_foto_dio/services/login_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailcontrolller = TextEditingController();
  final _passwordCOntrller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 152, 60, 198)),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Login',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _emailcontrolller,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    label: Text('Email'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(28),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email inválido';
                    }
                    if (!value.contains('@') || !value.contains('.com')) {
                      return 'Email inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _passwordCOntrller,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    label: Text('Password'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(28),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 8) {
                      return 'Senha inválida';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: _onPressed, child: const Text('Login'))
              ],
            ),
          )),
    );
  }

  void _onPressed() {
    if (!_formKey.currentState!.validate()) return;
    final controller = LoginController(
      loginRepository: LoginrepositoryImpl(service: LoginService()),
    );
    controller
        .signUp(_emailcontrolller.text, _passwordCOntrller.text)
        .then((value) {
      if (value == LoginState.loggedIn.name) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              ListContactsPage(viewModel: ControllerContacts()),
        ));
      } else {
        snackBarCustom(value!);
      }
    });
  }

  void snackBarCustom(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red[400],
      content: Text(
        msg.toUpperCase(),
        textAlign: TextAlign.center,
      ),
    ));
  }
}
