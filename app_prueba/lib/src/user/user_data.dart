
import 'package:app_prueba/src/firebase/firebase_bridge.dart';
import 'package:app_prueba/src/modules/auth/auth_provider.dart';
import 'package:app_prueba/src/modules/models/user_model.dart';
import 'package:app_prueba/src/user/update_data_form.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDataPage extends StatefulWidget {

  @override
  _UserDataPageState createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {

  bool onEdit = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Información de cuenta'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users')
            .doc(Provider.of<AuthProvider>(context).userUID).snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return Container();
              UserModel user = UserModel.fromJson(snapshot.data);
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Visibility(
                            visible: user.photoUrl == '',
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: Icon(
                                Icons.person_rounded, 
                                size: 100, 
                                color: Theme.of(context).colorScheme.background,),
                            ),
                            replacement: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Container(
                                width: 120,
                                height: 120,
                                child: CachedNetworkImage(
                                  imageUrl: user.photoUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -5,
                            right: -5,
                            child: IconButton(
                              onPressed: () async => await FirebaseBridge().updateUserPhoto(context), 
                              icon: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: Icon(Icons.camera_alt_rounded, color: Colors.black))
                            )
                          )
                        ],
                      ),
                      Expanded(
                        child: ListTile(
                          title: Text(user.email),
                          subtitle: Text('Correo'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Text('Información', style: Theme.of(context).textTheme.headline6,),
                      Spacer(),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>UpdateUserDataForm(user: user,)));
                      }, child: Text(!onEdit ? 'Editar' : 'Cancelar'))
                    ],
                  ),
                  ListTile(
                    title: Text(user.fullName),
                    subtitle: Text('Nombre'),
                  ),
                  ListTile(
                    title: Text(user.age == '' ? 'Sin registrar': '${user.age}'),
                    subtitle: Text('Edad'),
                  ),
                  ListTile(
                    title: Text(user.rfc == '' ? 'Sin registrar' : user.rfc),
                    subtitle: Text('RFC'),
                  ),
                  
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}