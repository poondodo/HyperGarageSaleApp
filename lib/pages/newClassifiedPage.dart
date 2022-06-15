import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'NewClassifiedForm.dart';

class NewClassifiedPage extends StatefulWidget {
  const NewClassifiedPage({Key? key}) : super(key: key);

  @override
  State<NewClassifiedPage> createState() => _NewClassifiedPageState();
}

class _NewClassifiedPageState extends State<NewClassifiedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Sale Post'),
      ),
      body: const NewClassifiedForm(),
    );
  }
}
