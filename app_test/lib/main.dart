import 'package:app_test/components/contact_affiche.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ContactsApp());
}

class Contact {
  final String nom;
  final String email;

  const Contact({required this.nom, required this.email});
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
  final List<Contact> _contacts = [];

  Future<void> _ajouterContact() async {
    final contact = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(builder: (context) => const ContactFormPage()),
    );

    if (!mounted || contact == null) return;

    setState(() {
      _contacts.add(contact);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Contact ajouté avec succès.')),
    );
  }

  void _ouvrirDetail(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactDetailPage(contact: contact),
      ),
    );
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

class ContactFormPage extends StatefulWidget {
  const ContactFormPage({super.key});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nomController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _enregistrer() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Opération réussie.')));

    final contact = Contact(
      nom: _nomController.text.trim(),
      email: _emailController.text.trim(),
    );

    Navigator.pop(context, contact);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un contact')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nom complet',
                  hintText: 'Ex. Awa Traoré',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final nom = value?.trim() ?? '';

                  if (nom.isEmpty) {
                    return 'Veuillez saisir le nom.';
                  }

                  if (nom.length < 2) {
                    return 'Le nom doit contenir au moins 2 caractères.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Adresse e-mail',
                  hintText: 'awa@example.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  final email = value?.trim() ?? '';

                  if (email.isEmpty) {
                    return 'Veuillez saisir l’adresse e-mail.';
                  }

                  final emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

                  if (!emailPattern.hasMatch(email)) {
                    return 'Veuillez saisir un e-mail valide.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _enregistrer,
                  icon: const Icon(Icons.save),
                  label: const Text('Enregistrer le contact'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactDetailPage extends StatelessWidget {
  final Contact contact;

  const ContactDetailPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détail du contact')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(radius: 32, child: Icon(Icons.person, size: 32)),
            const SizedBox(height: 24),
            Text(contact.nom, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(contact.email),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Retour à la liste'),
            ),
          ],
        ),
      ),
    );
  }
}
