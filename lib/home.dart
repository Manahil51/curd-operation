import 'package:curs/contact.dart';
import 'package:curs/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Contact> contacts = List.empty(growable: true);
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  bool _isEditing = false;
  int? _editingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Center(child: Text("Add Contact to List")),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                hintText: "First Name",
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                hintText: "Last Name",
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _contactController,
              keyboardType: TextInputType.number,
              maxLength: 11,
              decoration: const InputDecoration(
                hintText: "Contact Number",
                hintStyle: TextStyle(color: Colors.black),
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _isEditing ? _updateContact : _saveContact,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor:
                      _isEditing ? Colors.blue : Colors.green, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  elevation: 5, // Elevation
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15), // Padding
                ),
                child: Text(
                  _isEditing ? "Update" : "Save",
                  style: TextStyle(
                    fontSize: 16, // Text size
                    fontWeight: FontWeight.bold, // Text weight
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _cancelEdit,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  elevation: 3, // Elevation
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15), // Padding
                ),
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 16, // Text size
                    fontWeight: FontWeight.bold, // Text weight
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ContactsListView(
                  contacts: contacts,
                  onEdit: _startEditContact,
                  onDelete: _deleteContact,
                ),
              ));
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12), // Rounded corners
              ),
              elevation: 5, // Elevation
              padding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 15), // Padding
            ),
            child: const Text(
              "View Contacts",
              style: TextStyle(
                fontSize: 16, // Text size
                fontWeight: FontWeight.bold, // Text weight
              ),
            ),
          )
        ],
      ),
    );
  }

  void _saveContact() {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String contact = _contactController.text;

    if (firstName.isNotEmpty && lastName.isNotEmpty && contact.isNotEmpty) {
      setState(() {
        contacts.add(Contact(name: "$firstName $lastName", contact: contact));
        _firstNameController.clear();
        _lastNameController.clear();
        _contactController.clear();
      });
    }
  }

  void _updateContact() {
    if (_editingIndex != null) {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String contact = _contactController.text;

      if (firstName.isNotEmpty && lastName.isNotEmpty && contact.isNotEmpty) {
        setState(() {
          contacts[_editingIndex!] =
              Contact(name: "$firstName $lastName", contact: contact);
          _firstNameController.clear();
          _lastNameController.clear();
          _contactController.clear();
          _isEditing = false;
          _editingIndex = null;
        });
      }
    }
  }

  void _cancelEdit() {
    setState(() {
      _isEditing = false;
      _editingIndex = null;
      _firstNameController.clear();
      _lastNameController.clear();
      _contactController.clear();
    });
  }

  void _startEditContact(int index) {
    setState(() {
      _isEditing = true;
      _editingIndex = index;
      List<String> names = contacts[index].name.split(' ');
      _firstNameController.text = names[0];
      _lastNameController.text = names.length > 1 ? names[1] : '';
      _contactController.text = contacts[index].contact;
      Navigator.of(context).pop();
    });
  }

  void _deleteContact(int index) {
    setState(() {
      contacts.removeAt(index);
      Navigator.of(context).pop();
    });
  }
}
