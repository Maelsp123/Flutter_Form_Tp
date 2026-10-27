import 'package:app_test/models/contact.dart';

class ContactServices {
  List<Contact> _contacts = [
    Contact(nom: 'Awa Traoré', email: 'awa.traore@example.com'),
  ];

  getContacts() {
    return _contacts;
  }

  getContactByIndex(int index) {
    return _contacts[index];
  }

  addContact(Contact contact) {
    _contacts.add(contact);
  }

  deleteContact(Contact contact) {
    _contacts.remove(contact);
  }

  modifyContact(Contact oldContact, Contact newContact) {
    final index = _contacts.indexOf(oldContact);
    if (index != -1) {
      _contacts[index] = newContact;
    }
  }
}
