import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hyper_garage_sale_app/pages/detailPage.dart';
import 'package:hyper_garage_sale_app/services/authentication_service.dart';
import 'package:provider/provider.dart';

import '../services/firestore_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hyper Garage Sale'),
        leading: GestureDetector(
          onTap: () {
            context.read<AuthenticationService>().signOut();
          },
          child: const Icon(
            Icons.logout_sharp, // add custom icons also
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder(
            future: FirestoreService.readAll(),
            builder: (context, snapshot) {
              if (snapshot.hasData == false ||
                  snapshot.data == null ||
                  snapshot.data.toString() == '' ||
                  (snapshot.data as List).isEmpty) {
                return const Text(
                    'No items for sale. \nPlease click on + button to add a new classified'); // ,
              }
              List salePostList = snapshot.data as List;

              return ListView.builder(
                  itemCount: salePostList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailPage(info: salePostList[index]),
                            ),
                          );
                        },
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      // 'Title',
                                      salePostList[index]['title'].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                    Text(
                                      "\$ ${salePostList[index]['price'].toString()}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
                  } // itemBuilder
                  );
            } // builder
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newClassified');
        },
        tooltip: 'Add classified',
        child: const Icon(Icons.add),
      ),
    );
  }
}
