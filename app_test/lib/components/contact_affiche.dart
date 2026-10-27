import 'package:flutter/material.dart';
import 'package:app_test/models/contact.dart';

class ContactAffiche extends StatelessWidget {
  final Contact contact;
  final void Function(Contact)? onTap;

  const ContactAffiche({super.key, required this.contact, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amberAccent,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(contact.nom),
        subtitle: Text(contact.email),
        onTap: () => onTap?.call(contact),
        trailing: const Icon(Icons.info_outline),
      ),
    );
  }
}
