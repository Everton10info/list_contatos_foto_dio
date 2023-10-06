import 'package:flutter/material.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:list_contatos_foto_dio/contacts_view_model.dart';

class ListContactsPage extends StatefulWidget {
  const ListContactsPage({super.key, required this.viewModel});
  final ContactsVM viewModel;

  @override
  State<ListContactsPage> createState() => _ListContactsPageState();
}

class _ListContactsPageState extends State<ListContactsPage> {
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Cadastrar Contato'),
                      content: SizedBox(
                        height: 200,
                        child: Form(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                              TextFormField(),
                              TextButton(
                                onPressed: () {},
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.camera_alt_sharp,
                                  ),
                                  onPressed: () async {},
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Criar contato'))
                            ])),
                      ),
                      backgroundColor: Colors.white,
                    );
                  });
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 152, 60, 198),
            title: const Text(
              'CONTACTS',
            ),
          ),
          body: ValueListenableBuilder(
              valueListenable: widget.viewModel.listContacts,
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: widget.viewModel.listContacts.value.length,
                  itemBuilder: (context, index) {
                    final list = widget.viewModel.listContacts.value;
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(list[index].picture),
                        ),
                        title: Text(list[index].name),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.edit,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    );
                  },
                );
              })),
    );
  }
}
