
import 'package:flutter/material.dart';
import '../entity/entity_class.dart';



class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _numberTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  List contactList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact List', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _globalKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameTEController,
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                validator: (String? value) {
                  if(value?.trim().isEmpty == true){
                    return 'Write your name';
                  }
                  return null;
                },
          
              ),
              const SizedBox(height: 10,),
              TextFormField(
                controller: _numberTEController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Number',
                ),
                validator: (String? value) {
                  if(value?.trim().isEmpty == true){
                    return 'Write your number';
                  }
                  return null;
                },
          
              ),
              const SizedBox(height: 10,),
              ElevatedButton(onPressed: () {
                if(_globalKey.currentState!.validate()){
                  _addContactItem();
                  if(mounted){
                    setState(() {});
                  }

                }
                _getTextFieldClear();
          
              }, child: const Text('Add')),
              const SizedBox(height: 16,),
              Expanded(
                 child: ListView.builder(
                   itemCount: contactList.length,
                   primary: false,
                   shrinkWrap: true,
                   itemBuilder: (context, index) {
                     return Card(
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(4)
                       ),
                       child: _buildListTile(contactList[index], index),
                     );
                   },
                 )

              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget _buildListTile(Contact contact, int index) {
    return ListTile(
      leading: const Icon(
        Icons.person,
        color: Color(0xff755546),
        size: 24,
      ),
      title: GestureDetector(
        onLongPress: () {
          _deletePopupBox(index);
        },
        child: Text(
          contact.name,
          style: const TextStyle(
              color: Color(0xffD37573),
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
      subtitle: Text(contact.number),
      trailing: const Icon(
        Icons.call,
        color: Color(0xff4D92E7),
      ),
    );
  }

  void _addContactItem(){
    Contact contact = Contact(
        name: _nameTEController.text,
        number: _numberTEController.text,
    );
    contactList.add(contact);

  }
  void _deleteItem(index){
    contactList.removeAt(index);
    if(mounted){
      setState(() {

      });
    }
  }
  void _getTextFieldClear(){
    _numberTEController.clear();
    _nameTEController.clear();
  }

  void _deletePopupBox(index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          title: const Text(
            'Confirmation!',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          content: const Text('Are you sure for Delete?'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.cancel,
                  color: Color(0xff4D92E7),
                )),
            IconButton(
                onPressed: () {
                  _deleteItem(index);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete, color: Color(0xff4D92E7)))
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameTEController.dispose();
    _numberTEController.dispose();
  }
}
