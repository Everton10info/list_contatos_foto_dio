import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:list_contatos_foto_dio/cam_services.dart';
import 'package:list_contatos_foto_dio/contacts_view_model.dart';

class ListContactsPage extends StatefulWidget {
  const ListContactsPage({super.key, required this.viewModel});
  final ContactsVM viewModel;

  @override
  State<ListContactsPage> createState() => _ListContactsPageState();
}

class _ListContactsPageState extends State<ListContactsPage> {
  final textEditingController = TextEditingController();
  final file = ValueNotifier<XFile?>(null);

  @override
  void initState() {
    initList();
    super.initState();
  }

  initList() async {
    widget.viewModel.showContacts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 152, 60, 198),
          title: const Text(
            'CONTACTS',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ValueListenableBuilder(
              valueListenable: widget.viewModel.listContacts,
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: widget.viewModel.listContacts.value.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: ValueKey(
                          widget.viewModel.listContacts.value[index].objectId),
                      onDismissed: (_) => widget.viewModel.deleteContact(
                          widget.viewModel.listContacts.value[index].objectId),
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
                                backgroundImage: Image.file(
                              File(widget
                                  .viewModel.listContacts.value[index].picture),
                            ).image),
                          ),
                          title: Text(
                            widget.viewModel.listContacts.value[index].name
                                .toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.fade),
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.edit,
                            ),
                            onPressed: () {},
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
                  return AlertDialog(
                    title: const Text('Cadastrar Contato'),
                    content: SizedBox(
                      height: 220,
                      child: Form(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                            TextFormField(
                              controller: textEditingController,
                            ),
                            ValueListenableBuilder(
                              builder: (context, value, child) {
                                return file.value == null
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.camera_alt_sharp,
                                        ),
                                        onPressed: () async {
                                          file.value =
                                              (await ImagePickerCustomer
                                                  .take())!;
                                        },
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          height: 150,
                                          child: CircleAvatar(
                                              backgroundImage: Image.file(
                                            fit: BoxFit.scaleDown,
                                            File(file.value!.path),
                                          ).image),
                                        ),
                                      );
                              },
                              valueListenable: file,
                            )
                          ])),
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            widget.viewModel.addContact(
                                textEditingController.text, file.value!.path);
                            file.value = null;
                            textEditingController.text = '';

                            Navigator.of(context).pop();
                          },
                          child: const Text('Criar contato')),
                    ],
                    backgroundColor: Colors.white,
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget preview() {
    setState(() {});
    return SizedBox(
        width: 60,
        child: Image.file(
          File(file.value!.path),
          fit: BoxFit.contain,
        ));
  }
}
