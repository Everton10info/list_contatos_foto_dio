import 'package:flutter/material.dart';
import 'package:list_contatos_foto_dio/contacts_view_model.dart';
import 'package:provider/provider.dart';

import 'contacts_list_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ContactsVM()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List Contatos',
      theme: ThemeData(useMaterial3: true, primaryColor: Colors.green),
      home: ListContactsPage(viewModel: ContactsVM()),
    );
  }
}
