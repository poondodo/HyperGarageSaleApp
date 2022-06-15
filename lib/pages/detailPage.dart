import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  // In the constructor, require a Todo.
  const DetailPage({Key? key, required this.info}) : super(key: key);

  // Declare a field that holds the Todo.
  final dynamic info;

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    var title = info['title'].toString();
    var price = info['price'].toString();
    var description = info['description'].toString();
    var url = info['list of photos'].toString();

    Widget titleSection = Container(
      padding: EdgeInsets.fromLTRB(30, 25, 30, 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.monetization_on,
            color: Colors.red[500],
          ),
          Text(price),
        ],
      ),
    );

    Widget descriptionSection = Padding(
      padding: EdgeInsets.fromLTRB(30, 5, 30, 10),
      child: Text(
        description,
        softWrap: true,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black45,
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Sale Post Detail'),
      ),
      body: ListView(
        children: [
          titleSection,
          descriptionSection,
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image.network(url),
          ),
        ],
      ),
    );
  }
}
