import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:list_contatos_foto_dio/models/user.dart';
import 'package:list_contatos_foto_dio/pages/login_page.dart';
import '../controllers/contacts_controller.dart';
import '../models/contacts_model.dart';

class ListContactsPage extends StatefulWidget {
  const ListContactsPage({super.key, required this.controller});
  final ControllerContacts controller;

  @override
  State<ListContactsPage> createState() => _ListContactsPageState();
}

class _ListContactsPageState extends State<ListContactsPage> {
  final _textEditingController = TextEditingController();
  late final ControllerContacts vm;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    vm = ControllerContacts();
    vm.showContacts();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.account_circle_rounded,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: 64,
                  child: Text(
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    UserApp.userName ?? '',
                    style: const TextStyle(
                        color: Colors.blueAccent, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            IconButton(
                onPressed: () {
                  widget.controller.logOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                icon: const Icon(
                  Icons.logout_sharp,
                  color: Colors.blueAccent,
                ))
          ],
          backgroundColor: const Color.fromARGB(255, 152, 60, 198),
          title: const Text(
            'CONTACTS',
            style: TextStyle(
                fontWeight: FontWeight.w900, color: Colors.blueAccent),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Observer(builder: (BuildContext context) {
              return vm.loader
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: vm.listContacts.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: ValueKey(vm.listContacts[index].objectId),
                          onDismissed: (_) => vm
                              .deleteContact(vm.listContacts[index].objectId!),
                          child: Container(
                            margin: const EdgeInsets.all(2),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.purple.shade50,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: ListTile(
                              leading: SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: CircleAvatar(
                                      foregroundImage: Image.file(
                                        File(vm.listContacts[index].picture),
                                      ).image,
                                      backgroundImage: Image.network(
                                              'https://cdn4.iconfinder.com/data/icons/meBaze-Freebies/512/add-user.png')
                                          .image)),
                              title: Text(
                                vm.listContacts[index].name.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    overflow: TextOverflow.fade),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.edit,
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return customDialog(
                                            'Editar contato',
                                            vm.listContacts[index],
                                            vm.listContacts[index].picture);
                                      });
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
            })),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return customDialog('Cadastrar Contato');
                });
          },
          child: const Icon(
            Icons.add,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }

  customDialog(
    String title, [
    ContactModel? contact,
    String? file,
  ]) {
    _textEditingController.text = contact?.name ?? '';
    String? file = contact?.picture;

    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        height: 240,
        child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                      controller: _textEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira nome válido!';
                        }
                        return null;
                      }),
                  Observer(
                    builder: (_) {
                      return (file == null && vm.file == null)
                          ? IconButton(
                              icon: const Icon(
                                size: 30,
                                Icons.camera_alt_sharp,
                              ),
                              onPressed: () async {
                                vm.takePhoto();
                              },
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 150,
                                child: InkWell(
                                  onTap: () async {
                                    vm.takePhoto();
                                  },
                                  child: CircleAvatar(
                                      backgroundImage: Image.network(
                                        'https://cdn4.iconfinder.com/data/icons/meBaze-Freebies/512/add-user.png',
                                      ).image,
                                      foregroundImage: Image.file(
                                        height: 20,
                                        fit: BoxFit.scaleDown,
                                        File(vm.file?.path ?? file!),
                                      ).image),
                                ),
                              ),
                            );
                    },
                  )
                ])),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (!_formKey.currentState!.validate() ||
                (vm.file == null && contact?.picture == null)) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.redAccent,
                  content: Text('Por favor, adicione nome e foto'),
                ),
              );
              return;
            }

            contact?.objectId == null
                ? vm.addContact(_textEditingController.text, vm.file!.path)
                : vm.editContact(
                    _textEditingController.text,
                    vm.file?.path ?? contact!.picture,
                    contact!.objectId!,
                  );
            vm.file = null;
            _textEditingController.text = '';

            Navigator.of(context).pop();
          },
          child: const Text('Ok'),
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
