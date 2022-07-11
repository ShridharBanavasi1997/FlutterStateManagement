import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      routes: {
        "/new-contact":(context)=> const NewContactView()
      },
    );
  }
}

class Contact {
  final String name;

  const Contact({required this.name});
}

class ContactBook {
  ContactBook._sharedInstance();

  static final ContactBook _shared = ContactBook._sharedInstance();

  factory ContactBook() => _shared;

  final List<Contact> _contacts = [];

  int get length => _contacts.length;

  void add({required Contact contact}) {
    _contacts.add(contact);
  }

  remove({required Contact contact}) {
    _contacts.remove(contact);
  }

  Contact? contact({required int ind}) =>
      _contacts.length > ind ? _contacts[ind] : null;
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contactBook = ContactBook();
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: ListView.builder(
        itemCount: contactBook.length,
        itemBuilder: (context, index) {
          final contact = contactBook.contact(ind: index)!;
          return ListTile(
            title: Text(contact.name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/new-contact");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class NewContactView extends StatefulWidget {
  const NewContactView({Key? key}) : super(key: key);

  @override
  State<NewContactView> createState() => _NewContactViewState();
}

class _NewContactViewState extends State<NewContactView> {
  late final TextEditingController _controller;


  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Enter Name.."
            ),
          ),
          TextButton(
              onPressed: (){
                final contact = Contact(name: _controller.text);
                ContactBook().add(contact: contact);
                Navigator.of(context).pop();
              },
              child: Text("Enter")
          )
        ],
      ),
    );
  }
}
