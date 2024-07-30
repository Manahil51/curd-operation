import 'package:curs/contact.dart';
import 'package:flutter/material.dart';

class ContactsListView extends StatefulWidget {
  final List<Contact> contacts;
  final void Function(int) onEdit;
  final void Function(int) onDelete;

  const ContactsListView({
    Key? key,
    required this.contacts,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  _ContactsListViewState createState() => _ContactsListViewState();
}

class _ContactsListViewState extends State<ContactsListView> {
  TextEditingController _searchController = TextEditingController();
  List<Contact> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _filteredContacts = widget.contacts;
    _searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterContacts() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = widget.contacts
          .where((contact) =>
              contact.name.toLowerCase().contains(searchTerm) ||
              contact.contact.toLowerCase().contains(searchTerm))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Center(child: Text("Contacts List")),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: _filteredContacts.isEmpty
                ? const Center(
                    child: Text(
                      "No Contacts yet....",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredContacts.length,
                    itemBuilder: (context, index) => Card(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: index % 2 == 0
                                ? Color.fromARGB(255, 21, 5, 239)
                                : Color.fromARGB(255, 86, 10, 218),
                            foregroundColor: Colors.white,
                            child: Text(
                              _filteredContacts[index].name[0],
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _filteredContacts[index].name,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                              Text(_filteredContacts[index].contact,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ],
                          ),
                          trailing: SizedBox(
                            width: 70,
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () => widget.onEdit(index),
                                    child: const Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                    onTap: () => widget.onDelete(index),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
