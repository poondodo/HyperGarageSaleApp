import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hyper_garage_sale_app/services/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class NewClassifiedForm extends StatefulWidget {
  const NewClassifiedForm({Key? key}) : super(key: key);

  @override
  State<NewClassifiedForm> createState() => _NewClassifiedFormState();
}

class _NewClassifiedFormState extends State<NewClassifiedForm> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  late String url;
  late File _imageFile;
  bool imagePicked = false;
  final picker = ImagePicker();

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _imageFile = File(pickedFile!.path);
      imagePicked = true;
    });
    uploadImageToFirebaseStorage();
    Navigator.pop(context);
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = File(pickedFile!.path);
      imagePicked = true;
    });
    uploadImageToFirebaseStorage();
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> uploadImageToFirebaseStorage() async {
    final Storage storage = Storage();
    url = await storage.upload(_imageFile);
  }

  Future<DocumentReference> addPostToPostsBook(
      String postTitle, String postPrice, String postDescription, String url) {
    return FirebaseFirestore.instance
        .collection('chun & zhu sale post list')
        .add(<String, dynamic>{
      'title': postTitle,
      'price': postPrice,
      'description': postDescription, // to be finished
      'list of photos': url, // to be finished
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }

  void _addNewClassifiedEntry() {
    addPostToPostsBook(titleController.text, priceController.text,
        descriptionController.text, url);

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Center(
                child: Text(
              'Title',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )),
            TextFormField(
              controller: titleController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter Title';
                }
                return null;
              },
            ),
            const Center(
                child: Text(
              'price',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )),
            TextFormField(
              controller: priceController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter price';
                }
                return null;
              },
            ),
            const Center(
                child: Text(
              'description',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            )),
            TextFormField(
              controller: descriptionController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter description';
                }
                return null;
              },
            ),
            if (imagePicked == true)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 100,
                  child: Image.file(
                    _imageFile,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              )
            else
              TextButton(
                  onPressed: () {
                    _showChoiceDialog(context);
                  },
                  child: const Icon(Icons.add_a_photo, size: 50)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        _addNewClassifiedEntry();
                      },
                      child: const Text('Add new post'))),
            ),
          ],
        ),
      ),
    );
  }
}
