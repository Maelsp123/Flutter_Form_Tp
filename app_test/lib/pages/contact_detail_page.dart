import 'package:flutter/material.dart';
import 'package:app_test/models/contact.dart';

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
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context, contact);
              },
            ),
            const SizedBox(height: 16),
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
