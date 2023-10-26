import 'package:flutter/material.dart';
import 'package:list_contatos_foto_dio/controllers/contacts_controller.dart';
import 'package:list_contatos_foto_dio/controllers/login_controller.dart';
import 'package:list_contatos_foto_dio/shared/enums/login_enum.dart';
import 'package:list_contatos_foto_dio/pages/contacts_list_page.dart';
import 'package:list_contatos_foto_dio/repositories/auth_repository.dart';
import 'package:list_contatos_foto_dio/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailcontroller = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool screenLogin = true;
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color.fromARGB(255, 152, 60, 198)),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  screenLogin ? 'Login' : 'Cadastrar',
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: _emailcontroller,
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
                  controller: _passwordController,
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
                  height: 24,
                ),
                Visibility(
                  visible: screenLogin == false,
                  child: TextFormField(
                    controller: _passwordConfirmController,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      label: Text('Confirm Password'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(28),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length < 8 ||
                          value != _passwordController.text) {
                        return 'As senhas não são iguais';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: screenLogin ? _onPressedLogin : _onPressedRegister,
                  child: Text(
                    screenLogin ? 'Login' : 'Rgister',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Visibility(
                  visible: screenLogin == true,
                  child: TextButton(
                      onPressed: () {
                        screenLogin = false;
                        setState(() {});
                      },
                      child: const Text('Quero me registrar')),
                ),
                Visibility(
                  visible: screenLogin == false,
                  child: TextButton(
                    onPressed: () {
                      screenLogin = true;
                      setState(() {});
                    },
                    child: const Text('Voltar Para Login'),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _onPressedLogin() {
    if (!_formKey.currentState!.validate()) return;
    final controller = LoginController(
      loginRepository: AuthRepositoryImpl(service: AuthService()),
    );
    controller
        .signUp(_emailcontroller.text, _passwordController.text)
        .then((value) {
      if (value == LoginState.loggedIn.name) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              ListContactsPage(controller: ControllerContacts()),
        ));
      } else {
        snackBarCustom(value!);
      }
    });
  }

  void _onPressedRegister() {
    if (!_formKey.currentState!.validate()) return;
    final controller = LoginController(
      loginRepository: AuthRepositoryImpl(service: AuthService()),
    );
    controller
        .createUser(_emailcontroller.text, _passwordController.text)
        .then((value) {
      if (value == 'ok') {
        screenLogin = true;
        setState(() {});
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
