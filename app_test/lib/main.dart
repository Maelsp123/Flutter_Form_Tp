import 'package:app_test/components/contact_affiche.dart';
import 'package:app_test/services/contact_services.dart';
import 'package:flutter/material.dart';
import 'package:app_test/pages/contact_form_page.dart';
import 'package:app_test/pages/contact_detail_page.dart';
import 'package:app_test/models/contact.dart';

void main() {
  runApp(const ContactsApp());
}

class ContactsApp extends StatelessWidget {
  const ContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mes contacts',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const ContactsPage(),
    );
  }
}

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final ContactServices _service = ContactServices();
  List<Contact> _contacts = [];

  void _chargerContacts() {
    _contacts = _service.getContacts();
  }

  Future<void> _ajouterContact() async {
    final contact = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(builder: (context) => const ContactFormPage()),
    );

    if (!mounted || contact == null) return;
    _service.addContact(contact);

    setState(() {
      _chargerContacts();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact ajouté avec succès.')),
    );
  }

  Future<void> _ouvrirDetail(Contact contact) async {
    final contactSupp = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(
        builder: (context) => ContactDetailPage(contact: contact),
      ),
    );

    if (!mounted || contactSupp == null) return;
    _service.deleteContact(contactSupp);

    setState(() {
      _chargerContacts();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact supprimé avec succès.')),
    );
  }

  @override
  void initState() {
    super.initState();
    _chargerContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mes contacts')),
      body: _contacts.isEmpty
          ? const Center(
              child: Text('Aucun contact. Ajoutez votre premier contact.'),
            )
          : ListView.builder(
              itemCount: _contacts.length,
              itemBuilder: (context, index) {
                final contact = _contacts[index];

                return ContactAffiche(contact: contact, onTap: _ouvrirDetail);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _ajouterContact,
        tooltip: 'Ajouter un contact',
        child: const Icon(Icons.add),
      ),
    );
  }
}
