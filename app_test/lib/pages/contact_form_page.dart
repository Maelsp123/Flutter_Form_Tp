import 'package:flutter/material.dart';
import 'package:app_test/models/contact.dart';

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
