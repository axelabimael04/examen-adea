import 'package:app_prueba/src/modules/navigation/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text('Inicio'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              FutureBuilder(
                future: FirebaseAuth.instance.currentUser.getIdToken(),
                builder: (context, snapshot){
                  return Column(
                    children: [
                      Text('Current User ${FirebaseAuth.instance.currentUser}'),
                      SizedBox(height: 20,),
                      Text('JWT: ${snapshot.data}')
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}