import 'dart:io';

import 'package:flutter/material.dart';
import 'package:list_contatos_foto_dio/contacts_model.dart';
import 'package:list_contatos_foto_dio/contacts_view_model.dart';
import 'package:provider/provider.dart';

class ListContactsPage extends StatefulWidget {
  const ListContactsPage({super.key, required this.viewModel});
  final ContactsVM viewModel;

  @override
  State<ListContactsPage> createState() => _ListContactsPageState();
}

class _ListContactsPageState extends State<ListContactsPage> {
  final textEditingController = TextEditingController();
  late final ContactsVM vm;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    vm = context.read<ContactsVM>();
    vm.showContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 152, 60, 198),
          title: const Center(
            child: Text(
              'CONTACTS',
              style: TextStyle(
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<ContactsVM>(builder: (context, vm, child) {
            return vm.loader
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: vm.listContacts.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ValueKey(vm.listContacts[index].objectId),
                        onDismissed: (_) =>
                            vm.deleteContact(vm.listContacts[index].objectId!),
                        child: Container(
                          margin: const EdgeInsets.all(2),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                              color: Colors.purple.shade50,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
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
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return customDialog('Cadastrar Contato');
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  customDialog(
    String title, [
    ContactModel? contact,
    String? file,
  ]) {
    textEditingController.text = contact?.name ?? '';
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
                      controller: textEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira nome válido!';
                        }
                        return null;
                      }),
                  Consumer<ContactsVM>(
                    builder: (context, vm, child) {
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
                ? vm.addContact(textEditingController.text, vm.file!.path)
                : vm.editContact(
                    textEditingController.text,
                    vm.file?.path ?? contact!.picture,
                    contact!.objectId!,
                  );
            vm.file = null;
            textEditingController.text = '';

            Navigator.of(context).pop();
          },
          child: const Text('Ok'),
        ),
      ],
      backgroundColor: Colors.white,
    );
  }
}
