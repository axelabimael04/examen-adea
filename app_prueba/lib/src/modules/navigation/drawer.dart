import 'package:app_prueba/src/modules/auth/auth_page.dart';
import 'package:app_prueba/src/modules/auth/auth_provider.dart';
import 'package:app_prueba/src/modules/auth/services/auth_services.dart';
import 'package:app_prueba/src/modules/models/user_model.dart';
import 'package:app_prueba/src/user/user_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Column(children: [
          Container(
            width: double.infinity,
            height: 250,
            color: Colors.blue,
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('users')
            .doc(Provider.of<AuthProvider>(context).userUID).snapshots(),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return Container();
              UserModel user = UserModel.fromJson(snapshot.data);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SafeArea(
                      child: Visibility(
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
                    ),
                    Column(
                      children: [
                        Text(user.fullName, style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontWeight: FontWeight.bold
                        ),),
                        Text(user.email, style: Theme.of(context).textTheme.caption.copyWith(
                          color: Theme.of(context).colorScheme.onBackground
                        ),)
                      ],
                    )
                  ],
                );
              }
            ),
          ),
          ListTile(
            leading: Icon(Icons.manage_accounts_rounded),
            title: Text('Información de cuenta'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>UserDataPage()));
            },
          ),
          Spacer(),
          ListTile(
            title: Text('Cerrar sesión'),
            trailing: Icon(Icons.logout_rounded),
            onTap: () async {
              await UserAuthProviders().signOutFirebase();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> AuthPage()));  
            },
          ),
          SizedBox(height: 30,)
        ],),
      ),
    );
  }
}